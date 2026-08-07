{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib.meta) getExe;
  inherit (lib.strings) concatStringsSep;

  sessionData = config.services.displayManager.sessionData.desktops;
in
{
  services.greetd = {
    inherit (config.moon.profiles.graphical) enable;
    restart = true;
    useTextGreeter = true;

    settings = {
      default_session = {
        user = "greeter";
        command = concatStringsSep " " [
          (getExe pkgs.tuigreet)
          "--time"
          "--asterisks"
          "--sessions '${
            concatStringsSep ":" [
              "${sessionData}/share/xsessions"
              "${sessionData}/share/wayland-sessions"
            ]
          }'"
        ];
      };
    };
  };
}