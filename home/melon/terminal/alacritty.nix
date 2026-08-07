{
  config,
  lib,
  ...
}: let
  cfg = config.userSettings.alacritty;
in {
  options = {
    userSettings.alacritty = {
      enable = lib.mkEnableOption "Enable alacritty";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          opacity = 1;
          padding.x = 10;
          padding.y = 10;
          decorations = "Full";
          decorations_theme_variant = "Dark";
        };
        font = {
          normal.family = "JetBrainsMono Nerd Font";
          bold.family = "JetBrainsMono Nerd Font";
          italic.family = "JetBrainsMono Nerd Font";
          bold_italic.family = "JetBrainsMono Nerd Font";
          size = 14;
        };
        cursor.style.shape = "Beam";
      };
    };
  };
}
