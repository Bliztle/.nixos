{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/home-manager/home.nix
    # ./hyprland.nix
    # ./zsh.nix
    # ./git/git.nix
    # ./ssh.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "bliztle";
  home.homeDirectory = "/home/bliztle";


  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
 
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
      # org.gradle.console=verbose
      # org.gradle.daemon.idletimeout=3600000
      # # This is a gradle config comment
    # '';
  };

  # TODO: Figure out how to config this automatically
  # TODO: Currently manually set in browser
  # programs.librewolf = {
  #   enable = true;
  #   settings = {
  #     # These have to be strings, as they are passed to librewolf
  #     "identity.dxaccounts.enabled" = true; # I am fairly sure this didn't work, and i set it in the browser instead. May not carry over
  #   };
  # };

  # home.sessionVariables = {
  #   EDITOR = "nvim";
  #   SHELL = "zsh";
  #   XDG_CONFIG_DIR = "$HOME/.config";
  # };

  # xdg.mimeApps.defaultApplications = {
  #   "application/pdf" = [ "librewolf" ];
  # };

  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;
}
