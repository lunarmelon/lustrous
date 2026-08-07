{
  lib,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
  prof = config.moon.profiles;
in
{
  config = mkIf prof.laptop.enable {
    services.logind.settings.Login = {
      HandleLidSwitch = "ignore";
      HandleLidSwitchDocked = "ignore";
      HandleLidSwitchExternalPower = "ignore";
      HandlePowerKey = "suspend-then-hibernate";
    };
  };
}