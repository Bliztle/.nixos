# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:

let
  cfg = config.custom.locale;
in
{
  options.custom.locale = { };

  config = {
  
    # Set your time zone.
    time.timeZone = "Europe/Copenhagen";
  
    # Select internationalisation properties.
    i18n.defaultLocale = "en_DK.UTF-8";
  
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "da_DK.UTF-8";
      LC_IDENTIFICATION = "da_DK.UTF-8";
      LC_MEASUREMENT = "da_DK.UTF-8";
      LC_MONETARY = "da_DK.UTF-8";
      LC_NAME = "da_DK.UTF-8";
      LC_NUMERIC = "da_DK.UTF-8";
      LC_PAPER = "da_DK.UTF-8";
      LC_TELEPHONE = "da_DK.UTF-8";
      LC_TIME = "da_DK.UTF-8";
    };
  
    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "dk";
      # variant = "nodeadkeys";
    };
  };
}
