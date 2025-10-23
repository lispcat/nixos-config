{ ... }:

{
  laptop-config-gen = { inputs }:
    let
      user = "sui";
      system = "x86_64-linux";
      my-pkgs = import inputs.nixpkgs {
        system = inputs.system;
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
      system = system;  # for pkgs
      pkgs = my-pkgs;

      # provide args for all modules
      specialArgs = {
        inputs = inputs;
        user = user;
        pkgs-stable = import inputs.nixpkgs-stable { system = "x86_64-linux"; };
      };

      # submodules
      modules = [
        { nix.settings.keep-failed = true; }
        ./nixos/configuration.nix # NixOS
        ./home-manager/home.nix # Home-manager
      ];
    };
}
