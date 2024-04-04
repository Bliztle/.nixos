{ pkgs, lib, config, ... }:

{
  options = { };
  config = {
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
        # Applications
        obsidian-wayland # Uses overlay to force electron 24
        discord
        librewolf
        firefox
        spotify
        vscode # Change to programs.vscode and set package to newest git version
        bitwarden
        expressvpn
        # thunderbird -- Look into using nix' email settings

        # Tools
        wl-clipboard
        wdisplays
        tldr
        bat
        ripgrep
        fd
        eza
        # git        # This should already be accessible from git.nix
        # github-cli # -||-


        # Misc
        sl # TUU TUUUUUUUU


        # Misc dependencies
        libnotify # Required for notifications (dunst)
    ];
  };
}
