{
  lib,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
{
  config = mkIf config.moon.profiles.graphical.enable {
    programs.mpv = {
      enable = true;
    };
  };
}