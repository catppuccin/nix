import { z } from 'zod';
import yargs from 'yargs';
import { hideBin } from 'yargs/helpers';
import { readFile, readdir } from 'node:fs/promises';
import path from 'node:path';
import { UserstylesConfigManager } from './userstyles-config-manager.js';

const positionalArgsSchema = z.tuple([
  z.string().nonempty(),
  z.string().nonempty().optional()
]);

// this is catppuccin specific, it would be nice to make this generic
// adapted from https://github.com/catppuccin/userstyles/blob/11fd3b1c875a46b765ad5a4f8b4716b0df0d1624/scripts/utils.ts#L153C1-L162C2
async function getUserstylesFiles(stylesPath: string) {
  const files: string[] = [];
  const stylesDir = await readdir(stylesPath, { withFileTypes: true });
  for (const dir of stylesDir) {
    if (!dir.isDirectory) continue;
    files.push(
      path.join(stylesPath, dir.name, "catppuccin.user.less"),
    );
  }
  return files;
}

export async function loadInputs() {
  const argv = yargs(hideBin(process.argv))
    .usage('Usage: $0 <styles_path> [config_path]')
    .demandCommand(1)
    .parseSync();

  const [stylesPath, configPath] = positionalArgsSchema.parse(argv._);

  const userstylesFiles = await getUserstylesFiles(stylesPath);
  const userstyles = await Promise.all(
    userstylesFiles.map(userstyle => readFile(userstyle, 'utf-8'))
  );

  const configString = configPath ? await readFile(configPath, 'utf-8') : '{}';
  const rawConfig = JSON.parse(configString);
  const config = new UserstylesConfigManager(rawConfig);

  return { userstyles, config };
}
