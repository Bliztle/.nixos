{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/stable-hm.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "bliztle";
  home.homeDirectory = "/home/bliztle";

  custom.unstable.enable = false;
  custom.dev.enable = true;

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
  home.packages = [ ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = { };

  # Env variables for this user only
  # Defaults are set in zsh config
  home.sessionVariables = { };
}
