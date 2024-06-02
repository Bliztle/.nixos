{ pkgs, lib, config, ... }:

{
  options = {};
  config = {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;

      plugins = with pkgs.vimPlugins; [
          lazy-nvim
          nvim-treesitter
          nvim-treesitter.withAllGrammars # What is this dark magic?
          nvim-treesitter-context # Sticky functions
          auto-pairs
          nvim-ts-autotag
          nvim-surround # Surround with (ys | ds | cs){motion}{char}
          lualine-nvim
          nui-nvim # nvim ui components used by neo-tree-nvim
          plenary-nvim # nvim lua library used by telescope and neo-tree-nvim
          telescope-nvim
          telescope-fzf-native-nvim
          cheatsheet-nvim # :Cheatsheet to pull up a list of keybinds
          nvim-web-devicons # Icons for neo-tree-vim and lualine-nvim
          neo-tree-nvim
          which-key-nvim
          catppuccin-nvim # Color scheme 
          vim-sleuth # Auto detect tabs
          clangd_extensions-nvim # c/c++ integration
          copilot-vim
          comment-nvim
          markdown-preview-nvim

          # Git integration
          vim-fugitive
          vim-rhubarb # Github integration for issues / :GBrowse
                      # Azure integration is not in the nixos store. See https://github.com/cedarbaum/fugitive-azure-devops.vim
          gitsigns-nvim # Line annotations

          # Lsp and completion
          # Individual LSPs are installed in project shells
          nvim-lspconfig
          luasnip # Snippet framework
          nvim-cmp # Auto complete
          cmp-nvim-lsp # Get completions from lsp
          cmp-buffer # Get completions from buffer
          cmp_luasnip # Get completions from snippets
          lspkind-nvim # VSCode-like icons on completions
          nvim-dap # Debugger
          nvim-dap-ui # UI for Debugger
          qmk-nvim # QMK integration
      ];

      extraPackages = with pkgs; [
      	gcc # Supposedly needed for treesitter
        
        # Style
        stylua

        # Other 
        editorconfig-checker
        shellcheck
      ];

      extraLuaConfig = builtins.concatStringsSep "\n" ((map lib.strings.fileContents (import ./lua)) ++ []);

    };
  };
}
