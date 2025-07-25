{
  description = "My nix flake";

  ## Inputs:

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    renoise-source = {
      url = "file:/home/sui/opt/rns/rns_344_linux_x86_64.tar.gz";
      flake = false;
    };

    musnix = {
      url = "github:musnix/musnix";
    };
  };

  ## Outputs:

  outputs = inputs@{
    self, nixpkgs, nixpkgs-stable, home-manager, renoise-source, ...
  }:
    let
      user   = "sui";
      system = "x86_64-linux";
      pkgs        = import nixpkgs        { inherit system; };
      pkgs-stable = import nixpkgs-stable { inherit system; };
    in {
      nixosConfigurations.NixOwOs = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system inputs user pkgs-stable renoise-source;
        };
        modules = [
          inputs.musnix.nixosModules.musnix
          ./unfree-merger.nix
          ./nixos/configuration.nix
        ];
      };
      homeConfigurations.sui = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit user; };
        modules = [
          ./unfree-merger.nix
          ./home-manager/home.nix
        ];
      };
    };
}
