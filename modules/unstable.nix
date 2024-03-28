# This file gathers all the configuration specifically for the unstable channel

{ config, pkgs, inputs, lib, ... }:

{
  options.custom = {};

  imports =
    [
      inputs.home-manager-unstable.nixosModules.default
      ./nixos
    ];

  config = {
    custom.unstable.enable = true;
  };
}