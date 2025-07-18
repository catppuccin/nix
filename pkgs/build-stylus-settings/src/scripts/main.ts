import { loadInputs } from './inputs.js';
import { parseMeta, stringifyMeta } from './metadata.js';
import less from 'less';
import { generateStylusSections } from './sections.js';
import { calcStyleDigest } from './sections-util.js';
import { writeFile } from 'node:fs/promises';

async function main() {
  const { userstyles, config } = await loadInputs();

  const stylusStorage: Record<string, unknown> = {
    // required for stylus to continue to use storage.js file
    dbInChromeStorage: true,
  };

  for (const [index, userstyle] of userstyles.entries()) {
    const metadata = parseMeta(userstyle);

    if (!config.isEnabled(metadata.name)) continue;

    const bakedVars = Object.values(metadata.vars ?? {}).map((setting) => {
      let value = config.getSetting(metadata.name, setting.name, setting.default);
      if (typeof value === 'boolean') value = (+ value);
      return `@${setting.name}: ${value};`;
    }).join('\n');

    delete metadata.vars;
    delete metadata.updateURL;

    const bakedUserstyle = `
      ${stringifyMeta(metadata)}
      ${bakedVars}
      ${userstyle.replace(/\/\*[\s\S]*?\*\//, '')}
    `;

    const compiledUserstyle = (await less.render(bakedUserstyle)).css;

    const stylusUserstyle: Record<string, unknown> = {
      enabled: true,
      name: metadata.name,
      description: metadata.description,
      author: metadata.author,
      url: metadata.url,
      usercssData: metadata,
      sourceCode: bakedUserstyle,
      sections: generateStylusSections(compiledUserstyle),
      _id: crypto.randomUUID(),
      _rev: Date.now(),
      id: index + 1,
      inclusions: config.getProperty(metadata.name, 'inclusions'),
      exclusions: config.getProperty(metadata.name, 'exclusions')
    };

    stylusUserstyle.originalDigest = await calcStyleDigest(userstyle);

    stylusStorage[`style-${index + 1}`] = stylusUserstyle;
  }

  writeFile("storage.js", JSON.stringify(stylusStorage));
}

await main();
