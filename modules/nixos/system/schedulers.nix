{ pkgs, ... }:
{
  services.scx = {
    scheduler = "scx_bpfland";
    package = pkgs.scx.rustscheds;
  };
}