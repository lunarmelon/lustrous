{ config, ... }:
{
  services.tuned = {
    inherit (config.moon.profiles.laptop) enable;

    # auto magically change the profile based on the battery charging state
    ppdSettings.main.battery_detection = true;
  };
}