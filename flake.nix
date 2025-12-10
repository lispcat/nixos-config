{
  description = "My nix flake";

  ## Inputs:

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    # Declarative user environment.
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Music DAW with custom tarball.
    renoise-source.url = ./vendor/rns_353_linux_x86_64.tar.gz;
    renoise-source.flake = false;

    # Real-time audio in NixOS.
    musnix.url = "github:musnix/musnix";

    # Run unpatched dynamic binaries
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    # LSP server to visualize ownership and lifetimes in Rust.
    rustowl-flake.url = "github:nix-community/rustowl-flake";
  };

  ## Outputs:

  outputs = inputs@{ ... }:
    let
      laptop = import ./laptop;
      homelab = import ./homelab;

      system = "x86_64-linux";

      unfree-pkgs = [
        # music
        "vital"
        "spotify"
        "renoise"
        "reaper"
        "vcv-rack"
        # games
        "steam"
        "steam-original"
        "steam-unwrapped"
        "steam-run"
        "osu-lazer-bin"
      ];
      unfree-predicate = pkg: builtins.elem
        (inputs.nixpkgs.lib.getName pkg) unfree-pkgs;

      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfreePredicate = unfree-predicate;
      };
      pkgs-stable = import inputs.nixpkgs-stable {
        inherit system;
        config.allowUnfreePredicate = unfree-predicate;
      };

    in {
      nixosConfigurations = {
        laptop = laptop.laptop-config-gen {
          inherit inputs system pkgs pkgs-stable;
        };
        homelab = homelab.homelab-config-gen {
          inherit inputs system pkgs pkgs-stable;
        };
      };
    };
}
