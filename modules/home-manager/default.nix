{ config, pkgs, inputs, lib, ... }:

{
  options.custom = {
    unstable.enable = lib.mkEnableOption "enable configuration from unstable";
    nvidia.enable = lib.mkEnableOption "enable nvidia specific options";
    colorScheme = lib.mkOption { 
      default = "catppuccin-mocha";
    };
  };

  imports = [
    ./applications.nix
    ./dev/dev.nix
    ./email.nix
    ./git.nix
    ./dunst/dunst.nix
    ./hyprland/hyprland.nix
    ./kitty/kitty.nix
    ./neovim/neovim.nix
    ./waybar/waybar.nix
    ./work
    ./ssh.nix
    ./xdg.nix
    ./zsh/zsh.nix
    inputs.nix-colors.homeManagerModules.default # Nix colors import
  ];


  config = {
    # Schemes at: https://github.com/tinted-theming/base16-schemes
    # colorScheme = inputs.nix-colors.colorSchemes.tokyo-night-dark;
    colorScheme = inputs.nix-colors.colorSchemes.${config.custom.colorScheme};
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
