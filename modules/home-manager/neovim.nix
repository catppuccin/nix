{ config, pkgs, lib, ... }:
let
  cfg = config.programs.neovim.catppuccin;
in
{
  options.programs.neovim.catppuccin = lib.ctp.mkCatppuccinOpt "neovim" config;

  config.programs.neovim = with lib; mkIf cfg.enable {
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
            	flavour = "${cfg.flavour}",
            })

            vim.api.nvim_command("colorscheme catppuccin")
          EOF
        '';
      }
    ];
  };
}
