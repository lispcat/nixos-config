{
  description = "My nix flake";

  ## Inputs:

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  ## Outputs:

  outputs = inputs@{
    self, nixpkgs, nixpkgs-unstable, home-manager, ...
  }:
    let
      user   = "sui";
      system = "x86_64-linux";
      pkgs          = import nixpkgs        { inherit system; };
      pkgs-unstable = import nixpkgs-unstable { inherit system; };
    in {
      nixosConfigurations.NixOwOs = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system inputs user pkgs-unstable;
        };
        modules = [
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
