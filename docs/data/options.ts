import { readFileSync } from "node:fs";

const branches = ["main", "25.11", "25.05", "v1.1", "v1.2"];

export interface OptionData {
  declarations: string[];
  default: { _type: string; text: string };
  description: string;
  example?: { _type: string; text: string };
  loc: string[];
  readOnly: boolean;
  type: string;
}

export type OptionEntries = [string, OptionData][];
export type OptionsByModule = Record<string, OptionEntries>;
export type OptionsByType = Record<string, OptionsByModule>;
export type OptionsData = Record<string, OptionsByType>;

const groupOptionsByModule = (
  options: Record<string, OptionData>,
): OptionsByModule => {
  return Object.groupBy(Object.entries(options), ([optionName, _]) => {
    const optionNameParts = optionName.split(".");
    // Make the (somewhat naive) assumption that modules are either at the root namespace, or one level below
    // ex: `catppuccin.foo.enable` and `catppuccin.foo.bar.enable` => `catppuccin.foo`
    // ex: `catppuccin.enable` => `catppuccin`
    const cutoff = Math.min(2, optionNameParts.length - 1);
    return optionNameParts.splice(0, cutoff).join(".");
  }) as OptionsByModule;
};

const loadOptionsFromJSON = (
  version: string,
  type: string,
): OptionsByModule => {
  const data = JSON.parse(
    readFileSync(`./docs/data/${version}-${type}-options.json`, "utf-8"),
  );
  return groupOptionsByModule(data);
};

export const optionsData: OptionsData = Object.fromEntries(
  branches.map((version) => [
    version,
    {
      nixos: loadOptionsFromJSON(version, "nixos"),
      home: loadOptionsFromJSON(version, "home"),
    },
  ]),
);
