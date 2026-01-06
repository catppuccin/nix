import { readFileSync } from "node:fs";

const branches = ["main", "25.11", "25.05", "v1.1", "v1.2"];

const groupOptionsByModule = (options: Object) => {
  return Object.groupBy(Object.entries(options), ([optionName, _]) => {
    const optionNameParts = optionName.split(".");
    // Make the (somewhat naive) assumption that modules are either at the root namespace, or one level below
    // ex: `catppuccin.foo.enable` and `catppuccin.foo.bar.enable` => `catppuccin.foo`
    // ex: `catppuccin.enable` => `catppuccin`
    const cutoff = Math.min(2, optionNameParts.length - 1);
    return optionNameParts.splice(0, cutoff).join(".");
  });
};

const loadOptionsFromJSON = (version: string, type: string): Object => {
  const data = JSON.parse(
    readFileSync(`./docs/data/${version}-${type}-options.json`, "utf-8"),
  );
  const options = groupOptionsByModule(data);
  return options;
};

export const optionsData = Object.fromEntries(
  branches.map((version) => [
    version,
    {
      nixos: loadOptionsFromJSON(version, "nixos"),
      home: loadOptionsFromJSON(version, "home"),
    },
  ]),
);
