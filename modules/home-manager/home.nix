{ config, pkgs, inputs, lib, ... }:

{
  options.custom = {
    unstable.enable = lib.mkEnableOption "enable configuration from unstable";
    nvidia.enable = lib.mkEnableOption "enable nvidia specific options";
  };

  imports = [
    ./hyprland.nix
    ./zsh/zsh.nix
    ./git.nix
    ./ssh.nix
    ./applications.nix
    ./xdg.nix
  ];

  config = {
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
