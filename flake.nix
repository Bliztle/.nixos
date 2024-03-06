{
  description = "Nixos config flake";

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    #hyprland.url = "github:hyprwm/Hyprland";
    #hyprland-plugins = {
    #  url = "github:hyprwm/hyprland-plugins";
    #  inputs.hyprland.follows = "hyprland";
    #};

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
    
      nixosConfigurations = {

        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/desktop/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };

        zenbook = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/zenbook/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
      };
    };
}
