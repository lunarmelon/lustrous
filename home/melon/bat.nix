{ config, ... }:
let
  inherit (config.moon.programs) defaults;
in
{
  programs.bat = {
    inherit (config.moon.profiles.workstation) enable;

    config = {
      inherit (defaults) pager;
    };
  };
}