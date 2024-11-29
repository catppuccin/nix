{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.neovim.catppuccin;
  enable = cfg.enable && config.programs.neovim.enable;
in
{
  options.programs.neovim.catppuccin = lib.ctp.mkCatppuccinOpt { name = "neovim"; };

  config.programs.neovim = lib.mkIf enable {
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
}
