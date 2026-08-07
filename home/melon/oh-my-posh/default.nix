{
  config,
  lib,
  ...
}:
{
  programs.oh-my-posh = {
    inherit (config.moon.profiles.workstation) enable;
    configFile = ./melon.toml;
  };
}