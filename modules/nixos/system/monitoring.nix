{ lib, ... }:
let
  inherit (lib.modules) mkDefault;
in
{
  services = {
    # monitor and control temperature
    thermald.enable = true;

    # enable smartd monitoring
    smartd.enable = true;

    lvm.enable = mkDefault false;
  };
}