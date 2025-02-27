{ catppuccinLib }:
{ config, lib, ... }:
let
  cfg = config.catppuccin.nvim;

  defaultConfig = {
    compile_path = lib.generators.mkLuaInline "compile_path";
    flavour = cfg.flavor;
  };
in
{
  options.catppuccin.nvim = catppuccinLib.mkCatppuccinOption { name = "neovim"; } // {
    settings = lib.mkOption {
      description = "Extra settings that will be passed to the setup function.";
      default = { };
      type = lib.types.submodule { freeformType = lib.types.attrsOf lib.types.anything; };
      apply = lib.recursiveUpdate defaultConfig;
    };
  };

  imports = catppuccinLib.mkRenamedCatppuccinOptions {
    from = [
      "programs"
      "neovim"
      "catppuccin"
    ];
    to = "nvim";
  };

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      plugins = [
        {
          plugin = config.catppuccin.sources.nvim;
          config = ''
            lua << EOF
              local compile_path = vim.fn.stdpath("cache") .. "/catppuccin-nvim"
              vim.fn.mkdir(compile_path, "p")
              vim.opt.runtimepath:append(compile_path)

              require("catppuccin").setup(${lib.generators.toLua { } cfg.settings})

              vim.api.nvim_command("colorscheme catppuccin")
            EOF
          '';
        }
      ];
    };
  };
}
