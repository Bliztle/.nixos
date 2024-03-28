{ config, pkgs, inputs, ... }:

{
  imports = [
    ./home-manager
  ];

  custom.unstable.enable = true;
}
