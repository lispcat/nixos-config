{ ... }:

{
  homelab-config-gen = { inputs }:
    let
      user = "rin";
      system = "x86_64-linux";
    in inputs.nixpkgs.lib.nixosSystem {
      system = system;

      # provide args for all modules
      specialArgs = {
        inputs = inputs;
        user = user;
        pkgs-stable = import inputs.nixpkgs-stable { system = "x86_64-linux"; };
      };

      # submodules
      modules = [
        ./homelab-system/nixos/configuration.nix # NixOS
        ./homelab-system/home-manager/home.nix # Home-manager
      ];
    };

}
