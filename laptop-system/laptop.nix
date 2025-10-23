{ ... }:

{
  laptop-config-gen = { inputs }:
    let
      user = "sui";
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
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
      inherit system pkgs;
      # provide args for all modules
      specialArgs = {
        inherit inputs user;
        pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
      };
      # submodules
      modules = [
        { nix.settings.keep-failed = true; }
        ./nixos/configuration.nix
        ./home-manager/home.nix
      ];
    };
}
