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

  outputs = inputs@{ ... }:
    let
      laptop-system = let
        user = "sui";
        system = "x86_64-linux";
      in inputs.nixpkgs.lib.nixosSystem {
        inherit system;  # for pkgs
        # provide args for all modules
        specialArgs = {
          inherit inputs user;
          pkgs-stable = import inputs.nixpkgs-stable { system = "x86_64-linux"; };
        };

        # submodules to eval
        modules = [
          # NixOS
          ./laptop-system/nixos/configuration.nix

          # Home-manager setup
          inputs.home-manager.nixosModules.home-manager

          # Home-manager config
          {
            home-manager = {
              useGlobalPkgs = true;  # use system pkgs
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs user; };
              users.${user} = import ./laptop-system/home-manager/home.nix;
            };
          }

          # Function to allow unfree packages
          ./unfree-merger.nix
        ];
      };

    in {

      # NixOS
      nixosConfigurations = {
        # laptop
        inherit laptop-system;
      };

    };
}
