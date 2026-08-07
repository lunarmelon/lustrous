{ config, ... }:
{
  programs.zoxide = {
    inherit (config.moon.profiles.workstation) enable;

    options = [ "--cmd cd" ];
  };
}