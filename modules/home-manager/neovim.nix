{ catppuccinLib }:
{
  config,
  lib,
  ...
}:

let
  cfg = config.catppuccin.nvim;

  toLuaValue =
    value:
    if builtins.isAttrs value then
      toLuaTable value
    else if lib.isString value || lib.isPath value then
      ''"${toString value}"''
    else if lib.isList value then
      "{${lib.strings.concatStringsSep "," (map toLuaValue value)}}"
    else if lib.isBool value then
      if value == true then "true" else "false"
    else
      toString value;

  toLuaTable =
    attrset:
    let
      values = lib.strings.concatStringsSep "," (
        lib.attrsets.mapAttrsToList (name: value: "${name} = ${toLuaValue value}") attrset
      );
    in
    "{${values}}";
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

              local catppuccin_custom_plugin_settings = ${toLuaTable cfg.extraConfig}

              local catppuccin_plugin_settings = {
                compile_path = compile_path,
                flavour = "${cfg.flavor}",
              }

              for key, value in pairs(catppuccin_custom_plugin_settings) do
                catppuccin_plugin_settings[key] = value
              end

              require("catppuccin").setup(catppuccin_plugin_settings)

              vim.api.nvim_command("colorscheme catppuccin")
            EOF
          '';
        }
      ];
    };
  };
}
