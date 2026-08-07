{
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 15;
    consoleMode = "max";

    #bootCounting.enable = true;

    # Fix a security hole. See desc in nixpkgs/nixos/modules/system/boot/loader/systemd-boot/systemd-boot.nix
    editor = false;
  };
}
