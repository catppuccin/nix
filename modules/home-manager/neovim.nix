{ catppuccinLib }:
{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.programs.neovim.catppuccin;
in

{
  options.programs.neovim.catppuccin = catppuccinLib.mkCatppuccinOption { name = "neovim"; };

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      plugins = with pkgs.vimPlugins; [
        {
          plugin = catppuccin-nvim;
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
