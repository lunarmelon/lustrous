{ config, ... }:
{
  programs.gh = {
    enable = config.programs.git.enable && config.moon.profiles.workstation.enable;

    settings = {
      prompt = "enabled";
    };
  };
}