{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
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

        default = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [ 
            # ./hosts/desktop/configuration.nix
            ./hosts/desktop/configuration.nix
            # /home/bliztle/.nixos/hosts/desktop/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
      };
    };
}
