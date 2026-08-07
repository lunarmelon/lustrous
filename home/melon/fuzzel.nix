{
  osConfig,
  lib,
  config,
  pkgs,
  self,
  ...
}:
let
  inherit (lib) mkIf mkOptionDefault getExe;

  inherit (osConfig.moon.system) sway;
in
{
  config = mkIf sway.enable {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          font = "JetBrainsMono Nerd Font:size=14";
          fields = "name,filename,name,generic,categories, keywords";
          show-action = "yes";
          lines = 10;
          width = 40;
          tabs = 8;
          horizontal-pad = 30;
          terminal = "${getExe config.programs.kitty.package}";
          exit-on-keyboard = "no";
          icon-theme = "Papirus-Dark";
        };
      };
    };
  };
}