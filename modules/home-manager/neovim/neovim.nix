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
      ];

      extraPackages = with pkgs; [
      	gcc # Supposedly needed for treesitter
        
        # Style
        stylua

        # Other 
        editorconfig-checker
        shellcheck
      ];

      # extraConfig = ''
      #   set number relativenumber

      #   " Move between windows with Ctrl + h/j/k/l
      #   nnoremap <C-h> <C-w>h
      #   nnoremap <C-j> <C-w>j
      #   nnoremap <C-k> <C-w>k
      #   nnoremap <C-l> <C-w>l

      #   " Telescope keybindings
      #   nnoremap <leader>ff <cmd>Telescope find_files<cr>
      #   nnoremap <leader>fg <cmd>Telescope live_grep<cr>
      #   nnoremap <leader>fb <cmd>Telescope buffers<cr>
      #   nnoremap <leader>fh <cmd>Telescope help_tags<cr>
      # '';

      extraLuaConfig = builtins.concatStringsSep "\n" ((map lib.strings.fileContents (import ./lua)) ++ []);

      # extraLuaConfig = ''
      # 	vim.g.mapleader = " " -- Set leader before lazy for correct keybindings;
      # 	vim.g.maplocalleader = " "

      # 	require("lazy").setup({
      #     spec = {
      #       -- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
      #       -- Import plugins from lua/plugins
      #       { import = "plugins" },
      #     },
	    #     performance = {
      #       reset_packpath = false,
      #       rtp = {
      #           reset = false,
      #       },
	    #     },
	    #     dev = {
	    #       path = "${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
      #       patterns = {
      #         "folke", "nvim-telescope", "nvim-treesitter", "nvim-neo-tree", "plenary.nvim", "nvim-web-devicons", "nui.nvim", "nvim-lspconfig", "cheatsheet.nvim", "nvim-autopairs"
      #       }
      #     },
	    #     install = {
	    #       -- Safeguard in case we forget to install a plugin with Nix
	    #       missing = false,
	    #     },
	    #   })
      # '';
    };

    # xdg.configFile."nvim/lua" = {
    #   recursive = true;
    #   source = ./lua;
    # };
  };
}
