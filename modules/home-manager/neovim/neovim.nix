{ pkgs, lib, config, ... }:

{
  options = {};
  config = {
    programs.neovim = {
      enable = true;

      plugins = with pkgs.vimPlugins; [
        auto-pairs
        nui-nvim # nvim ui components used by neo-tree-nvim
        plenary-nvim # nvim lua library used by telescope and neo-tree-nvim
        telescope-nvim
        cheatsheet-nvim # :Cheatsheet to pull up a list of keybinds
        nvim-web-devicons # Icons for neo-tree-vim
        neo-tree-nvim
        which-key-nvim
      ];
    };
  };
}
