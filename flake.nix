{
  description = "Config Flake de hry223";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      desktop-nvidia = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
# Change ce bloc :
modules = [
  ./hosts/desktop-nvidia/configuration.nix
  home-manager.nixosModules.home-manager
  {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    # ICI IL Y AVAIT UNE ACCOLADE EN TROP
    home-manager.users.hry223 = {
      imports = [ ./home-manager/home.nix ];
    };
  } # CETTE ACCOLADE FERME LE BLOC DE CONFIGURATION
];	

      };
      laptop-intel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/laptop-intel/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.hry223 = import ./home-manager/home.nix;
          }
        ];
      };
    };
  };
}
