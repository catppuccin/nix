{ catppuccinLib }:
{ config, lib, ... }:
let
  cfg = config.catppuccin.nvim;
  pluginSettings = lib.generators.toLua { } (defaultConfig // cfg.extraConfig);

  defaultConfig = {
    compile_path = lib.generators.mkLuaInline "compile_path";
    flavour = cfg.flavor;
  };
in
{
  options.catppuccin.nvim = catppuccinLib.mkCatppuccinOption { name = "neovim"; } // {
    extraConfig = lib.mkOption {
      description = "Extra settings that will be passed to the setup function.";
      default = { };
      type = lib.types.attrs;
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

              require("catppuccin").setup(${pluginSettings})

              vim.api.nvim_command("colorscheme catppuccin")
            EOF
          '';
        }
      ];
    };
  };
}
