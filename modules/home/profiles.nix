{
  lib,
  config,
  osConfig,
  ...
}:
{
  config = {
    moon.profiles = {
      inherit (osConfig.moon.profiles)
        graphical
        workstation
        laptop
        server
        ;
    };
  };
}