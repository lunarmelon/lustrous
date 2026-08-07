{
  time = {
    timeZone = "America/Mexico_City";
    hardwareClockInLocalTime = true;
  };

  services.timesyncd.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us,latam";
    variant = "";
  };
}
