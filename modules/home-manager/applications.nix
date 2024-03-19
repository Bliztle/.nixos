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

    programs.lf.enable = true;

    nixpkgs.overlays = [
      (final: prev: {
        obsidian-wayland = prev.obsidian.override {electron = final.electron_24;};
      }) 
    ];

    home.file.".vscode/argv.json".text = ''
      {
        "enable-crash-reporter": false,
        "password-store": "gnome-libsecret"
      }
    '';

    home.packages = with pkgs; [
        obsidian-wayland
        # libsecret
    ];
  };
}
