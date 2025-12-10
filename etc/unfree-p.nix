let
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
  unfree-predicate = nixpkgs: pkg:
    builtins.elem (nixpkgs.lib.getName pkg) unfree-pkgs;
in
unfree-predicate
