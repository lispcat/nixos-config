{
  description = "My nix flake";

  ## Inputs:

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    # Declarative user environment.
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Real-time audio in NixOS.
    musnix.url = "github:musnix/musnix";

    # Run unpatched dynamic binaries
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    # LSP server to visualize ownership and lifetimes in Rust.
    rustowl-flake.url = "github:nix-community/rustowl-flake";
  };

  ## Outputs:

  outputs = { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";

      unfree-p = import ./etc/unfree-p.nix nixpkgs;

      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfreePredicate = unfree-p;
      };
      pkgs-stable = import inputs.nixpkgs-stable {
        inherit system;
        config.allowUnfreePredicate = unfree-p;
      };

      # Boilerplate killer (hacky warning...)
      # Wraps `content` with stuff needed to add it to module system.
      # Returns an attrset. If other code outside scope of invocation,
      # may need to splice with inherit or separate then merge attrsets.
      mkFeature = name: desc: body:
        { config, lib, ... }: with lib; {
          options.features.${name}.enable =
            if desc != null
            then mkOption {
              type = types.bool;
            } else mkOption {
              type = types.bool;
              description = desc;
            };
          config = mkIf config.features.${name}.enable body;
        };

      # Function to create a system config.
      # Based on: https://github.com/sioodmy/dotfiles/blob/main/flake.nix
      mkSystem = title: hostname: user:
        nixpkgs.lib.nixosSystem {
          inherit pkgs system;
          specialArgs = {
            inherit inputs user system pkgs-stable mkFeature;
          };
          modules = [
            # hostname
            { networking.hostName = hostname; }

            # system lib
            ./modules/system/default.nix

            # home-manager lib
            ./modules/home/default.nix

            # host: hardware-config + config flags
            ./hosts/${title}/default.nix
          ];
        };
    in {
      nixosConfigurations = {
        laptop = mkSystem "laptop" "NixOwOs" "sui";
        homelab = mkSystem "homelab" "nixos" "rin";
      };
    };
}
