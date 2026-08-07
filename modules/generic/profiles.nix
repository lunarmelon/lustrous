{ lib, ... }:
let
  inherit (lib.options) mkEnableOption;
in
{
  options.moon.profiles = {
    graphical.enable = mkEnableOption "Graphical interface";
    workstation.enable = mkEnableOption "Workstation";
    laptop.enable = mkEnableOption "Laptop";
    server.enable = mkEnableOption "Server";
  };
}