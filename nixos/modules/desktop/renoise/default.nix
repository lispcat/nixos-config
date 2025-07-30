{ pkgs, renoise-source, ... }:

let
  renoise-nix = ./renoise-352.nix;

  renoise-custom = with pkgs;
    let
      rns =
        ((pkgs.callPackage renoise-nix {})
          .override( { releasePath = renoise-source; } ));
      rns-wrapped = pkgs.writeShellScriptBin "renoise" ''
        exec ${pkgs.util-linux}/bin/unshare -r -n -- ${pkgs.steam-run-free}/bin/steam-run ${rns}/bin/renoise "$@"
      '';
    in rns-wrapped;
in
{
  nixpkgs.allowUnfreePackages = [
    "renoise"
    "reaper"
  ];

  environment.systemPackages = with pkgs; [
    # renoise packages
    renoise-custom
    steam-run-free

    rubberband  # check if the second attr set overwrites rubberband & mpg123
    mpg123

    reaper
  ];

  # warnings = [
  #   "renoise-pkg contains: ${toString (builtins.length renoise-pkg)} packages"
  #   "regular-pkgs contains: ${toString (builtins.length regular-pkgs)} packages"
  # ];

}
