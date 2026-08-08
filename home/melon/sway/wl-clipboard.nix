{
  lib,
  pkgs, 
  config,
  osConfig,
  self,
  ...
}:
let
  inherit (lib) mkIf;

  inherit (osConfig.moon.system) sway;
in
{
  config = mkIf sway.enable {
    moon.packages = { inherit (pkgs) wl-clipboard; };
    
    services.cliphist.enable = true;
  };
}