import fs from "fs";
import path from "path";
import usercssMeta from "usercss-meta";
import { calcStyleDigest } from "./sections-util.js";
import less from "less";
import postcss from "postcss";

async function getStylesDir(): Promise<string | null> {
  if (process.argv.length < 3) return null;

  const stylesPath = process.argv[2];
  const stylesStat = await fs.promises.stat(stylesPath);

  if (!stylesStat.isDirectory) return null;

  return stylesPath;
}

type UserstylesOptions = Record<string, Record<string, string | number>>;

function isRecord(obj: unknown): obj is Record<string, unknown> {
  return typeof obj === "object" && obj !== null && !Array.isArray(obj);
}

function isStringOrNumber(value: unknown): value is string | number {
  return typeof value === "string" || typeof value === "number";
}

function isValidUserstylesOptions(obj: unknown): obj is UserstylesOptions {
  if (!isRecord(obj)) return false;

  for (const value of Object.values(obj)) {
    if (!isRecord(value)) return false;
    if (!Object.values(value).every(isStringOrNumber)) return false;
  }

  return true;
}

async function getUserstylesOptions(): Promise<UserstylesOptions> {
  if (process.argv.length < 4) return {};
  const jsonPath = process.argv[3];
  const rawData = await fs.promises.readFile(jsonPath, "utf8");
  const json = JSON.parse(rawData);

  if (!isValidUserstylesOptions(json)) {
    throw new Error("Invalid JSON");
  }

  const lowercased: UserstylesOptions = {};
  for (const [key, value] of Object.entries(json)) {
    lowercased[key.toLowerCase()] = value;
  }

  return lowercased;
}

function getUserstylesFiles(stylesDir: string): string[] {
  const files: string[] = [];
  for (const dir of fs.readdirSync(stylesDir, { withFileTypes: true })) {
    if (!dir.isDirectory) continue;
    files.push(
      path.join(stylesDir, dir.name, "catppuccin.user.less"),
    );
  }
  return files;
}

function getUserstylesOption(
  userstylesOptions: UserstylesOptions,
  key: string,
  subKey: string,
): string | number | null {
  if (!(key in userstylesOptions)) return null;
  if (!(subKey in userstylesOptions[key])) return null;
  return userstylesOptions[key][subKey];
}

function bakeUserstyleVar(
  name: string,
  info: unknown,
  metadata: usercssMeta.Metadata,
  userstylesOptions: UserstylesOptions,
): string {
  let value = getUserstylesOption(
    userstylesOptions,
    `Userstyle ${metadata.name}`.toLowerCase(),
    name,
  );

  if (value === null) {
    value = getUserstylesOption(userstylesOptions, "global", name);
  }

  if (
    value === null &&
    isRecord(info) &&
    "default" in info &&
    isStringOrNumber(info.default)
  ) {
    value = info.default;
  }

  if (value === null) {
    throw new Error(`Could not find value for ${metadata.name} ${name}`);
  }

  return `@${name}: ${value};`;
}

function generateSections(
  userstyleBlock: string,
  css: string,
): Record<string, unknown>[] {
  const cssRoot: postcss.Root = postcss.parse(css);

  const sections = [
    {
      code: userstyleBlock,
      start: 0,
    },
  ] as Record<string, unknown>[];

  cssRoot.walkAtRules("-moz-document", (rule: postcss.AtRule) => {
    const innerCss = rule.nodes?.map((n) => n.toString()).join("\n") ?? "";
    const section = {
      code: innerCss,
      start: sections.map((s) => s.code).join().length,
    } as Record<string, unknown>;

    function addRule(rule: string, value: string) {
      if (Array.isArray(section[rule])) {
        section[rule].push(value);
      } else {
        section[rule] = [value];
      }
    }

    const conditions: string[] = (rule.params ?? "").split(", ");
    conditions.forEach((condition) => {
      const match = condition.match(/^([\w-]+)\("(.+)"\)$/);

      if (match) {
        const value = match[2].replace(/\\\\/g, "\\");

        switch (match[1]) {
          case "domain":
            addRule("domains", value);
            break;
          case "regexp":
            addRule("regexps", value);
            break;
          case "url-prefix":
            addRule("urlPrefixes", value);
            break;
        }
      }
    });

    rule.remove();
    sections.push(section);
  });

  cssRoot.walkComments((comment) => {
    comment.remove();
    return;
  });
  const unhandledCss = cssRoot.toString().trim();
  if (unhandledCss.length > 0) {
    throw new Error(`Unhandled CSS '${unhandledCss}'`);
  }

  return sections;
}

async function generateStorageData(): Promise<Record<string, unknown>> {
  const data: Record<string, unknown> = {
    // required for stylus to continue to use storage.js file
    dbInChromeStorage: true,
  };

  const stylesDir = await getStylesDir();
  if (stylesDir === null) throw new Error("Expected path to styles directory");

  const userstylesOptions = await getUserstylesOptions();

  for (const [index, file] of getUserstylesFiles(stylesDir).entries()) {
    const content = await fs.promises.readFile(file, "utf8");
    const { metadata } = usercssMeta.parse(content);

    const styleEnabled = getUserstylesOption(
      userstylesOptions,
      `Userstyle ${metadata.name}`.toLowerCase(),
      "enable",
    )

    if (styleEnabled === 0) continue;

    if ("updateURL" in metadata) {
      delete metadata.updateURL;
    }

    const fileInfo = await fs.promises.stat(file);
    const mtime = fileInfo.mtime ? fileInfo.mtime.getTime() : 0;

    const vars = metadata.vars || {};
    const lessVars = Object.entries(vars).map(
      ([name, info]) =>
        bakeUserstyleVar(name, info, metadata, userstylesOptions),
    ).join("\n");
    for (const key in metadata.vars) {
      delete metadata.vars[key];
    }

    const userstyleBlockNoVars =
      usercssMeta.stringify(metadata, { alignKeys: true }) + "\n";
    const contentBakedVars = lessVars + "\n" +
      content.replace(/\/\*\s*==UserStyle==[\s\S]*?==\/UserStyle==\s*\*\//, "");

    const compiledCss = await (async () => {
      try {
        return (await less.render(contentBakedVars, { filename: file })).css;
      } catch (err) {
        throw new Error(`Failed to compile LESS in ${file}: ${err}`);
      }
    })();

    const sections = (() => {
      try {
        return generateSections(userstyleBlockNoVars, compiledCss);
      } catch (err) {
        throw new Error(`Failed to compile LESS in ${file}: ${err}`);
      }
    })();

    const userstyle = {
      enabled: true,
      name: metadata.name,
      description: metadata.description,
      author: metadata.author,
      url: metadata.url,
      usercssData: metadata,
      sourceCode: userstyleBlockNoVars + contentBakedVars,
      sections: sections,
      _id: crypto.randomUUID(),
      _rev: mtime,
      id: index + 1,
    } as Record<string, unknown>;

    userstyle.originalDigest = await calcStyleDigest(userstyle);

    data[`style-${index + 1}`] = userstyle;
  }

  return data;
}

(async () => {
  const storageData = await generateStorageData();
  await fs.promises.writeFile("storage.js", JSON.stringify(storageData));
})();
