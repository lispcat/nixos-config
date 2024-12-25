{ pkgs, renoise-source, ... }:

let
  renoise-nix = ./renoise-344.nix;
in

if builtins.pathExists renoise-source
then with pkgs;
  let
    renoise =
      ((pkgs.callPackage renoise-nix {})
        .override( { releasePath = renoise-source; } ));
    body =
      {
        
        programs.firejail.wrappedBinaries.renoise = {
          executable = "${renoise}/bin/renoise";
          profile = "${pkgs.firejail}/etc/firejail/renoise.profile";
        };
        environment.etc = {
          "firejail/renoise.profile".text = ''
            net=none
          '';
        };
        nixpkgs.allowUnfreePackages = [
          "renoise"
        ];
        environment.systemPackages = with pkgs; [
          rubberband
          mpg123
        ];
        
      };
  in { body };
else { };

# renoise-pkg ++ regular-pkgs
# --noprofile --caps.drop=all --net=none --nonewprivs \
