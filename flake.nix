{
  description = "My nix flake";

  ## Inputs:

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # Declarative user environment.
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Music DAW with custom tarball.
    renoise-source.url = "file:/home/sui/opt/rns/rns_352_linux_x86_64.tar.gz";
    renoise-source.flake = false;

    # Real-time audio in NixOS.
    musnix.url = "github:musnix/musnix";

    # LSP server to visualize ownership and lifetimes in Rust.
    rustowl-flake.url = "github:nix-community/rustowl-flake";
  };

  ## Outputs:

  outputs =
    inputs@{ self
           , nixpkgs
           , nixpkgs-stable
           , ...
           }:
    let
      user   = "sui";
      system = "x86_64-linux";

      pkgs        = import nixpkgs { inherit system; };
      pkgs-stable = import nixpkgs-stable { inherit system; };

      laptop-system = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          inputs.musnix.nixosModules.musnix
          ./unfree-merger.nix
          ./nixos/configuration.nix
        ];
        specialArgs = { inherit inputs user system pkgs-stable; };
      };

      laptop-home = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit user; };
        modules = [
          ./unfree-merger.nix
          ./home-manager/home.nix
        ];
      };

    in {

      # NixOS
      nixosConfigurations = {
        # laptop
        laptop-system = laptop-system;
      };

      # Home Manager
      homeConfigurations = {
        # laptop
        laptop-home = laptop-home;
      };
    };
}
