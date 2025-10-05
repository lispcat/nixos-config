{ pkgs, lib, inputs, ... }:

let
  rns-pkg = pkgs.callPackage ./renoise-352.nix {
    # custom tarball installer
    releasePath = inputs.renoise-source;
  };

  renoise-custom = lib.pipe rns-pkg [
    # runtime dependencies
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
        # unshare = "${pkgs.util-linux}/bin/unshare -r -n";
        steam-run = "${pkgs.steam-run-free}/bin/steam-run";
        renoise = "${rns}/bin/renoise";
      in
        # pkgs.writeShellScriptBin "renoise" ''
        #   exec ${unshare} -- ${steam-run} ${renoise} "$@"
        # ''
        pkgs.writeShellScriptBin "renoise" ''
          exec ${steam-run} ${renoise} "$@"
        ''
    )
  ];
in
renoise-custom
