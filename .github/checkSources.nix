let
  sources = (builtins.fromJSON (builtins.readFile ../.sources/sources.json)).pins;

  isGithubSource = source: source.repository.type or "" == "GitHub";
  isInOrg = source: source.repository.owner or "" == "catppuccin";

  # all github sources should be from the org
  isGoodSource = source: isGithubSource source -> isInOrg source;
  # find the ones that aren't
  badSources = builtins.filter (source: !(isGoodSource source)) (builtins.attrValues sources);
in
  if ((builtins.length badSources) == 0)
  then "OK"
  else throw "BAD"
