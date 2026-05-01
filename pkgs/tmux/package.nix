{
  lib,
  sources,
  tmuxPlugins,
}:

let
  portName = "tmux";
in

tmuxPlugins.mkTmuxPlugin rec {
  pluginName = "catppuccin";
  version = "0${lib.optionalString (src ? "lastModified") "-unstable-${toString src.lastModified}"}";

  src = sources.${portName};

  meta = {
    description = "Soothing pastel theme for ${portName}";
    homepage = "https://github.com/catppuccin/${portName}";
    license = lib.licenses.mit;
  };
}
