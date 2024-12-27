{ catppuccinLib }:
{
  config,
  lib,
  ...
}:

let
  cfg = config.catppuccin.nvim;
in

{
  options.catppuccin.nvim = catppuccinLib.mkCatppuccinOption { name = "neovim"; };

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

              require("catppuccin").setup({
              	compile_path = compile_path,
              	flavour = "${cfg.flavor}",
              })

              vim.api.nvim_command("colorscheme catppuccin")
            EOF
          '';
        }
      ];
    };
  };
}
