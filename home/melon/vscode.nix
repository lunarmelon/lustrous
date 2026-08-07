{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.moon.programs.vscode;
in
{
  options.moon.programs.vscode.enable = mkEnableOption "Enable vscode";

  config = mkIf cfg.enable {
    programs.vscode.enable = true;
  };
}
