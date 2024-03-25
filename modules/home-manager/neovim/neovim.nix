{ pkgs, lib, config, ... }:

{
  options = {};
  config = {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      withNodeJs = true;
      # package = pkgs.neovim-nightly;

      plugins = with pkgs.vimPlugins; [
      	LazyVim
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
      ];

      extraPackages = with pkgs; [
      	gcc
        stylua
      ];

      extraConfig = ''
        set number relativenumber
      '';

      extraLuaConfig = ''
      	vim.g.mapleader = " " -- Set leader before lazy for correct keybindings;
      	vim.g.maplocalleader = " "

      	require("lazy").setup({
          spec = {
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
              "nvim-telescope, nvim-treesitter"
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
