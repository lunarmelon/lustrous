{ config, ... }:
{
  # remove stupid sites that i just don't want to see
  networking.stevenblack = {
    enable = true;
    block = [
      "fakenews"
      "gambling"
      "porn"
      # "social"
    ];
  };
}