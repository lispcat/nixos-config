{ inputs, ... }:

{
  homelab-config-gen = { inputs }:
    let
      user = "rin";
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfreePredicate =
          pkg: builtins.elem (inputs.nixpkgs.lib.getName pkg) [
            # games
            "steam" "steam-original" "steam-unwrapped" "steam-run"
          ];
      };
    in inputs.nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      specialArgs = {
        inherit inputs user system;
        pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
      };
      modules = [
        ./nixos
        ./home
      ];
    };

}
