{ config, pkgs, inputs, lib, ... }:

{
  options.custom = {
    unstable.enable = lib.mkEnableOption "enable configuration from unstable";
    nvidia.enable = lib.mkEnableOption "enable nvidia specific options";
  };

  imports = [
    ./applications.nix
    ./git.nix
    ./hyprland.nix
    ./neovim/neovim.nix
    ./ssh.nix
    ./xdg.nix
    ./zsh/zsh.nix
  ];

  config = {
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
