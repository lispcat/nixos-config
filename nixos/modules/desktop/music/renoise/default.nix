{ pkgs, lib, renoise-source, ... }:

let
  rns-pkg = pkgs.callPackage ./renoise-352.nix { };

  renoise-custom = lib.pipe rns-pkg [
    # custom tar.gz
    (rns: rns.override { releasePath = renoise-source; })
    # add steam-run-free to buildInputs
    (rns: rns.overrideAttrs
      (oldAttrs: {
        buildInputs = (oldAttrs.buildInputs or []) ++ [ 
          pkgs.steam-run-free
        ];
      })
    )
    # wrap in FHS sandbox with no internet
    (rns:
      let
        unshare = "${pkgs.util-linux}/bin/unshare -r -n";
        steam-run = "${pkgs.steam-run-free}/bin/steam-run";
        renoise = "${rns}/bin/renoise";
      in
        pkgs.writeShellScriptBin "renoise" ''
          exec ${unshare} -- ${steam-run} ${renoise} "$@"
        ''
    )
  ];
in
renoise-custom
