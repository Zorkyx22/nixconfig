{
  description = "Hive system configuration";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };
  
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let 
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      Hive = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
	modules = [./system/configuration.nix];
      };
    };
    homeConfigurations = {
      sire_n1chaulas = home-manager.lib.homeManagerConfiguration {
	inherit pkgs;
        modules = [ ./home/home.nix ];
      };
    };
  };
}
