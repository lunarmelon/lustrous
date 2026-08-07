{
  lib,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
{
  programs.keepassxc = {
    inherit (config.moon.profiles.graphical) enable;
  };
}