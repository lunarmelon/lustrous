{ config, ... }:
{
  programs.eza = {
    inherit (config.moon.profiles.workstation) enable;
    icons = "auto";

    enableZshIntegration = false;

    extraOptions = [
      "--group"
      "--group-directories-first"
      "--header"
      "--no-permissions"
      "--octal-permissions"
    ];
  };
}