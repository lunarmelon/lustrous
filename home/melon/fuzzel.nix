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
in
{
  config = mkIf config.moon.profiles.graphical.enable {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          font = "JetBrainsMono Nerd Font:size=14";
          fields = "name,filename,name,generic,categories,keywords";
          show-actions = "yes";
          lines = 10;
          width = 40;
          tabs = 8;
          horizontal-pad = 30;
          terminal = "${getExe config.programs.kitty.package}";
          exit-on-keyboard-focus-loss = "no";
          icon-theme = "Papirus-Dark";
        };
      };
    };
  };
}