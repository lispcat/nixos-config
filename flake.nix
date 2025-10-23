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
    # (Note: ModFXRender doesn't work yet on 3.5)
    renoise-source.url = "file:/home/sui/opt/rns/rns_353_linux_x86_64.tar.gz";
    renoise-source.flake = false;

    # Real-time audio in NixOS.
    musnix.url = "github:musnix/musnix";

    # LSP server to visualize ownership and lifetimes in Rust.
    rustowl-flake.url = "github:nix-community/rustowl-flake";
  };

  ## Outputs:

  outputs = inputs@{ ... }:
    let
      laptop-system =
        let
          user = "sui";
          system = "x86_64-linux";
          my-pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfreePredicate = pkg: builtins.elem (inputs.nixpkgs.lib.getName pkg) [
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
          };
        in inputs.nixpkgs.lib.nixosSystem {
          inherit system;  # for pkgs
          pkgs = my-pkgs;

          # provide args for all modules
          specialArgs = {
            inherit inputs user;
            pkgs-stable = import inputs.nixpkgs-stable { system = "x86_64-linux"; };
          };

          # submodules
          modules = [
            { nix.settings.keep-failed = true; }
            ./laptop-system/nixos/configuration.nix # NixOS
            ./laptop-system/home-manager/home.nix # Home-manager
          ];
        };

      homelab-system =
        let
          user = "rin";
          system = "x86_64-linux";
        in inputs.nixpkgs.lib.nixosSystem {
          inherit system;

          # provide args for all modules
          specialArgs = {
            inherit inputs user;
            pkgs-stable = import inputs.nixpkgs-stable { system = "x86_64-linux"; };
          };

          # submodules
          modules = [
            ./homelab-system/nixos/configuration.nix # NixOS
            ./homelab-system/home-manager/home.nix # Home-manager
          ];
        };
    in {
      # nixos config
      nixosConfigurations = {
        laptop = laptop-system;
        homelab = homelab-system;
      };
    };
}
