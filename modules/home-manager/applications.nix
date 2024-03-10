{ pkgs, lib, config, ... }:

{
  options = { };
  config = {
    # All configuration is done in program.zsh
    
    # Obsidian configuration
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.permittedInsecurePackages = [
      # "electron-25-9-0"
      "electron-24.8.6" # This is required for the obsidian changes for wayland, listed below
    ];

    nixpkgs.overlays = [
      (final: prev: {
        obsidian-wayland = prev.obsidian.override {electron = final.electron_24;};
      }) 
    ];

    home.packages = with pkgs; [
        obsidian-wayland
    ];
  };
}
