{
  imports = [
    ./formatter.nix
  ];

  perSystem = 
    {
      pkgs,
      inputs',
      config,
      ...
    }:
    {
      devShells.default = pkgs.mkShellNoCC {
        name = "dotfiles";
        meta.description = "development environment for this flake";

        inputsFrom = [ config.formatter ];

        DIRENV_LOG_FORMAT = "";

        packages = [
          pkgs.gitMinimal
          config.formatter
        ];
      };
    };
}