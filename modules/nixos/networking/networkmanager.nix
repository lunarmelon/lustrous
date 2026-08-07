{ 
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.attrsets) optionalAttrs;
in
{
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    unmanaged = [
      "interface-name:tailscale*"
      "interface-name:br-*"
      "interface-name:rndis*"
      "interface-name:docker*"
      "interface-name:virbr*"
      "interface-name:vboxnet*"
      "interface-name:waydroid*"
      "type:bridge"
    ];

    wifi = {
      backend = "iwd";

      powersave = config.moon.profiles.laptop.enable;
    };
  };
}