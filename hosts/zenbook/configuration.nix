# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

let
  userinfo = {
    username = "bliztle";
  };
in
{
  imports =
    [ # Include the results of the hardware scan
      ./hardware-configuration.nix
    ];
  
  # Main user
  main-user.enable = true;
  main-user.userName = userinfo.username;

  # Do not use unstable releases
  custom.unstable.enable = false;

  custom.displaymanager.enable = true;
  custom.displaymanager.gdm.enable = true;
  custom.vpn.enable = true;

  custom.security = {
    enable = true;
    yubico.u2f = true;
  };

  # Home manager
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "${userinfo.username}" = import ./home.nix;
    };
  };

  networking.hostName = "zenbook"; # Define your hostname.
  
  # Configure console keymap
  console.keyMap = "dk-latin1";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
