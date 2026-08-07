{
  security = {
    run0 = {
      enable = true;

      # wheelNeedsPassword means wheel group can execute commands without
      # a password so just disable it
      wheelNeedsPassword = false;

      # install run0-sudo-shim
      sudo-shim.enable = true;
    };

    sudo.enable = false;
    sudo-rs.enable = false;
  };
}