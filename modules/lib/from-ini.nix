# Simplifying assumptions:
#
# - ASCII
# - line feed separated lines
# - no multiline elements
# - `=` surrounded by single space on both sides or not
# - no subsections
# - supported comment forms:
#   - line that starts with `#`
# - values are either not quoted or single quoted
# - blank lines are supported
# - otherwise no extra whitespace
lib: ini:
let
  lines = lib.strings.splitString "\n" ini;
  parsedLines = map parseLine lines;

  parseLine = line:
    if builtins.stringLength line == 0
    then { type = "empty"; }
    else if lib.hasPrefix "#" line
    then { type = "comment"; }
    else if lib.hasPrefix "[" line
    then {
      type = "section";
      name = lib.pipe line [(lib.removePrefix "[") (lib.removeSuffix "]")];
    }
    else let
      parts = lib.splitString "=" line;
      key = lib.removeSuffix " " (lib.elemAt parts 0);
      litVal = lib.removePrefix " " (lib.elemAt parts 1);
    in {
      type = "property";
      inherit key;
      val = lib.pipe litVal [(lib.removePrefix "'") (lib.removeSuffix "'")];
    }
  ;

  endState = lib.foldl foldState { val = {}; currentSection = null; } parsedLines;

  foldState = acc: line:
    if line.type == "empty"
    then acc
    else if line.type == "comment"
    then acc
    else if line.type == "section"
    then acc // { ${line.name} = {}; currentSection = line.name; }
    else if line.type == "property"
    then lib.updateManyAttrsByPath
      [{
        path = lib.flatten [
          "val"
          (lib.optional (builtins.isString acc.currentSection) acc.currentSection)
          line.key
        ];
        update = _: line.val;
      }]
      acc
    else throw "no such type ${line.type}"
  ;
in
  endState.val
