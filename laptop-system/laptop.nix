{ ... }:

{
  laptop-config-gen = { inputs }:
    let
      user = "sui";
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfreePredicate = pkg:
          builtins.elem (inputs.nixpkgs.lib.getName pkg) [
            # music
            "vital" "spotify" "renoise" "reaper" "vcv-rack"
            # games
            "steam" "steam-original" "steam-unwrapped" "steam-run"
            "osu-lazer-bin"
          ];
      };
    in inputs.nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      specialArgs = {  # provide args for all modules
        inherit inputs user system;
        pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
      };
      modules = [  # load modules
        {
          nix.settings = {
            keep-failed = true;
            experimental-features = [ "nix-command" "flakes" ];
            download-buffer-size = 524288000;
          };
        }

        # main nixos config
        ./nixos/default.nix

        # nix home config
        ./home-manager/default.nix

        # setup nix-ld
        inputs.nix-ld.nixosModules.nix-ld
        {
          programs.nix-ld.dev.enable = true;
        }
      ];
    };
}
