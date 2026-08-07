{ lib, config, ... }:
let
  inherit (lib.modules) mkIf;
in
{
  # compress half of the ram to use as swap
  # <https://chrisdown.name/2026/03/24/zswap-vs-zram-when-to-use-what.html>
  boot.zswap = {
    enable = config.swapDevices != [ ];

    maxPoolPercent = mkIf config.moon.profiles.server.enable 15;
  };
}