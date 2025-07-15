{ pkgs }:

let
  renoise-source = /home/sui/opt/rns/rns_344_linux_x86_64.tar.gz;

  renoise-nix = ./renoise-344.nix;

  regular-pkgs = with pkgs; [
    rubberband  # check if the second attr set overwrites rubberband & mpg123
    mpg123
  ];

  renoise-pkg =
    if builtins.pathExists renoise-source
    then with pkgs;
      let
        renoise =
          ((pkgs.callPackage renoise-nix {})
            .override( { releasePath = renoise-source; } ));
        wrapped =
          pkgs.writeShellScriptBin "renoise" ''
            exec ${pkgs.util-linux}/bin/unshare -r -n -- ${renoise}/bin/renoise "$@"
          '';
      in [ wrapped ]
    else [];
in
{
  environment.systemPackages = renoise-pkg ++ regular-pkgs;
}
