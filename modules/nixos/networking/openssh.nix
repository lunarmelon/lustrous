{
  self,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkOption;
  inherit (lib.types) bool;

  cfg = config.moon.networking.openssh;
in
{
  options.moon.networking.openssh = {};

  config = {
    services.openssh = {
      enable = true;
      startWhenNeeded = true;

      allowSFTP = true;

      openFirewall = true;
      ports = [ 22 ];

      settings = {
        PermitRootLogin = "no";

        # Use key exchange algorithms recommended by `nixpkgs#ssh-audit`
        KexAlgorithms = [
          "curve25519-sha256"
          "curve25519-sha256@libssh.org"
          "diffie-hellman-group16-sha512"
          "diffie-hellman-group18-sha512"
          "sntrup761x25519-sha512@openssh.com"
          "diffie-hellman-group-exchange-sha256"
          "mlkem768x25519-sha256"
          "sntrup761x25519-sha512"
        ];

        # Use Macs recommended by `nixpkgs#ssh-audit`
        Macs = [
          "hmac-sha2-512-etm@openssh.com"
          "hmac-sha2-256-etm@openssh.com"
          "umac-128-etm@openssh.com"
        ];

        # kick out inactive sessions
        ClientAliveCountMax = 5;
        ClientAliveInterval = 60;
      };
    };
  };
}