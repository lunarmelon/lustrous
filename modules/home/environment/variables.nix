{
  config,
  osConfig,
  ...
}:
let
  inherit (config.moon.programs) defaults;
in
{
  home.sessionVariables = {
    EDITOR = defaults.editor;
    GIT_EDITOR = defaults.editor;
    VISUAL = defaults.editor;
    TERMINAL = defaults.terminal;
    SYSTEMD_PAGERSECURE = "true";
    DO_NOT_TRACK = 1;
  };
}