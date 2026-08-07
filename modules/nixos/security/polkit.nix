{ config, ... }:
{
  security = {
    polkit = {
      enable = true;

      enablePkexecWrapper = false;
    };

    soteria.enable = config.moon.profiles.graphical.enable;
  };
}