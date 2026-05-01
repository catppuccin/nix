{
  lib,
  vimUtils,
  sources,
}:

let
  portName = "nvim";
in

vimUtils.buildVimPlugin rec {
  pname = "catppuccin-nvim";
  version = "0${lib.optionalString (src ? "lastModified") "-unstable-${toString src.lastModified}"}";

  src = sources.${portName};

  nvimSkipModule = [
    "catppuccin.groups.integrations.noice"
    "catppuccin.groups.integrations.feline"
    "catppuccin.lib.vim.init"
  ];

  meta = {
    description = "Soothing pastel theme for ${portName}";
    homepage = "https://github.com/catppuccin/${portName}";
    license = lib.licenses.mit;
  };
}
