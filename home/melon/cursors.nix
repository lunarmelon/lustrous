{ pkgs, config, ... }:
{
  # pointer / cursor theming
  home = {
    pointerCursor = {
      enable = config.moon.profiles.graphical.enable;
      package = pkgs.bibata-cursors;
      size = 24;
      name = "Bibata-Modern-Classic";
      dotIcons.enable = false;
      gtk.enable = true;
      x11.enable = false;
    };
  };
}