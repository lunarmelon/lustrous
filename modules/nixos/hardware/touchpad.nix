{config, ...}:
{
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = config.moon.profiles.laptop.enable;

    # disable mouse acceleration
    mouse = {
      accelProfile = "flat";
      accelSpeed = "0";
      middleEmulation = false;
    };

    # touchpad settings
    touchpad = {
      naturalScrolling = true;
      tapping = true;
      clickMethod = "clickfinger";
      disableWhileTyping = true;
    };
  };
}
