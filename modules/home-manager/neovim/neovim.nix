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
      	# LazyVim
	      lazy-nvim
	      nvim-treesitter
	      nvim-treesitter.withAllGrammars # What is this dark magic?
        auto-pairs
        nui-nvim # nvim ui components used by neo-tree-nvim
        plenary-nvim # nvim lua library used by telescope and neo-tree-nvim
        telescope-nvim
        telescope-fzf-native-nvim
        cheatsheet-nvim # :Cheatsheet to pull up a list of keybinds
        nvim-web-devicons # Icons for neo-tree-vim
        neo-tree-nvim
        which-key-nvim
	      nvim-lspconfig
      ];

      extraPackages = with pkgs; [
      	gcc # Supposedly needed for treesitter
        
        # Style
        stylua

        # Other 
        editorconfig-checker
        shellcheck
      ];

      extraConfig = ''
        set number relativenumber

        " Move between windows with Ctrl + h/j/k/l
        nnoremap <C-h> <C-w>h
        nnoremap <C-j> <C-w>j
        nnoremap <C-k> <C-w>k
        nnoremap <C-l> <C-w>l

        " Telescope keybindings
        nnoremap <leader>ff <cmd>Telescope find_files<cr>
        nnoremap <leader>fg <cmd>Telescope live_grep<cr>
        nnoremap <leader>fb <cmd>Telescope buffers<cr>
        nnoremap <leader>fh <cmd>Telescope help_tags<cr>
      '';

      extraLuaConfig = ''
      	vim.g.mapleader = " " -- Set leader before lazy for correct keybindings;
      	vim.g.maplocalleader = " "

      	require("lazy").setup({
          spec = {
            -- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
            -- Import plugins from lua/plugins
            { import = "plugins" },
          },
	        performance = {
            reset_packpath = false,
            rtp = {
                reset = false,
            },
	        },
	        dev = {
	          path = "${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
            patterns = {
              "folke", "nvim-telescope", "nvim-treesitter", "nvim-neo-tree", "plenary.nvim", "nvim-web-devicons", "nui.nvim", "nvim-lspconfig", "cheatsheet.nvim"
            }
          },
	        install = {
	          -- Safeguard in case we forget to install a plugin with Nix
	          missing = false,
	        },
	      })
      '';
    };

    xdg.configFile."nvim/lua" = {
      recursive = true;
      source = ./lua;
    };
  };
}
