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
  version = builtins.substring 0 7 src.rev;

  src = sources.${portName};

  meta = {
    description = "Soothing pastel theme for ${portName}";
    homepage = "https://github.com/catppuccin/${portName}";
    license = lib.licenses.mit;
  };
}
