{
  osConfig,
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.attrsets) attrValues;

  inherit (lib) mkIf fileContents mkEnableOption;
in
{
  options.moon.programs.neovim.enable = mkEnableOption "Neovim";

  config = mkIf config.moon.programs.neovim.enable {
    xdg.configFile."nvim".source = ./config;

    moon.packages = {
      inherit (pkgs)
        clang
        python3
        libgcc
        lua
        luarocks
        rustc
        gnumake
        cargo
        nodejs
        ;
    };

    programs.neovim = {
      enable = true;

      viAlias = true;
      vimAlias = true;

      plugins = attrValues {
        inherit (pkgs.vimPlugins)
          # theme
          catppuccin-nvim

          # LSP 
          nvim-lspconfig
          
          # mini library
          mini-comment
          mini-completion
          mini-diff
          mini-extra
          mini-files
          mini-icons
          mini-notify
          mini-pairs
          mini-pick
          mini-snippets
          mini-surround
          mini-tabline

          # vscode snippets
          friendly-snippets

          # treesitter
          nvim-treesitter

          # efmls
          efmls-configs-nvim

          # json schemas
          SchemaStore-nvim

          # ibl
          indent-blankline-nvim

          # tmux
          vim-tmux-navigator

          # colorizer
          nvim-colorizer-lua

          # git client
          neogit

          # lualine
          lualine-nvim

          # git
          vim-fugitive

          # live server
          live-preview-nvim
        ;
      };

      extraPackages = attrValues {
        inherit (pkgs)
          bash-language-server
          vscode-langservers-extracted
          emmet-language-server
          lua-language-server
          nil
          tree-sitter
          efm-langserver

          selene
          stylua
          nixfmt
          statix
          ;
      };
    };
  };
}