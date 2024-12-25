{
  description = "My nix flake";

  ## Inputs:

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    renoise-source = {
      path = "/home/sui/opt/rns/rns_344_linux_x86_64.tar.gz";
      flake = false;
    }
  };

  ## Outputs:

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, home-manager, renoise-source, ... }:
    let
      user   = "sui";
      system = "x86_64-linux";
      
      pkgs        = import nixpkgs        { inherit system; };
      pkgs-stable = import nixpkgs-stable { inherit system; };
    in {
      nixosConfigurations.NixOwOs = nixpkgs.lib.nixosSystem
        {
          specialArgs = {
            inherit system inputs user renoise-source;
          };
          modules = [
            ./unfree-merger.nix
            ./nixos/configuration.nix
          ];
        };
      homeConfigurations.sui = home-manager.lib.homeManagerConfiguration
        {
          inherit pkgs;
          extraSpecialArgs = { inherit user; };
          modules = [
            ./unfree-merger.nix
            ./home-manager/home.nix
          ];
        };
    };
}
