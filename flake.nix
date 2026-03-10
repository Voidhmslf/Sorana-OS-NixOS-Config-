{
  description = "NixOS configuration for my beloved Void";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    minesddm = {
      url = "github:Davi-S/sddm-theme-minesddm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia-shell = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, minesddm, noctalia-shell, ... }: {
    nixosConfigurations = {
      sorana = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit minesddm noctalia-shell; };
        modules = [
          ./hosts/desktop/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit noctalia-shell; };
            home-manager.users.void = import ./home/default.nix;
          }
        ];
      };
    };
  };
}
