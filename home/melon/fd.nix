{ config, ... }:
{
  programs.fd = {
    inherit (config.moon.profiles.workstation) enable;

    hidden = true;
    ignores = [
      ".git/"
      "*.bak"
    ];
  };
}