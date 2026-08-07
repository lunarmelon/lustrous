{ osConfig, ... }:
{
  _class = "homeManager";
  
  imports = [
    ../generic
    ./environment
    ./profiles.nix
    ./programs
    ./themes
  ];

  config = {
    home.stateVersion = osConfig.system.stateVersion;
  };
}