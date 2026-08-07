{ lib, ... }:
{
  perSystem = 
  { pkgs, ... }:
  {
    formatter = pkgs.treefmt.withConfig {
      runtimeInputs = with pkgs; [
        nixfmt
        deadnix
        statix
        shellcheck
        shfmt

        (writeShellScriptBin "statix-fix" ''
          for file in "$@"; do
            ${lib.getExe statix} fix "$file"
          done
        '')
      ];

      settings = {
        on-unmatched = "info";
        tree-root-file = "flake.nix";

        formatter = {
          nixfmt = {
            command = "nixfmt";
            includes = [ "*.nix" ];
          };

          deadnix = {
            command = "deadnix";

            options = [ "--edit" ];
            includes = [ "*.nix" ];
          };

          statix = {
            command = "statix-fix";
            includes = [ "*.nix" ];
          };
        };
      };
    };
  };
}