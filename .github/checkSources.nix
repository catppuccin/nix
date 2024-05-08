let
  sourceFile = ../_sources/generated.json;
  sources = builtins.fromJSON (builtins.readFile sourceFile);
  isFromOrg = v: v.src.owner == "catppuccin";
  badSources = builtins.filter (src: !(isFromOrg src)) (builtins.attrValues sources);
in
  # error if any sources are found that don't originate
  # from the catppuccin org
  if ((builtins.length badSources) == 0)
  then "GOOD"
  else builtins.throw "BAD"
