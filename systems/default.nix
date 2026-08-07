{
  self,
  inputs,
  ...
}:
{
  imports = [ inputs.easy-hosts.flakeModule ];

  config.easy-hosts = {
    perClass = class: {
      modules = [
        "${self}/modules/${class}"
        "${self}/home"
      ];
    };

    hosts = {
      quartz = {};
    };
  };
}