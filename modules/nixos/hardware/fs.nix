{ config, ... }:
{
  # discard blocks that are not used by the filesystem, good for SSDs health
  services = {
    fstrim = {
      enable = true;
      interval = "weekly";
    };
  };
}