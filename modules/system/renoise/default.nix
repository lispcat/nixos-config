{ pkgs, pkgs-stable, inputs, mkFeature, ... }:

let
  din-is-noise   = pkgs.callPackage ./din-is-noise { withJack = true; };
  renoise-custom = pkgs.callPackage ./renoise { inherit inputs; };
  lsp-plugins    = pkgs.callPackage ./lsp-plugins {};
in {
  imports = [
    inputs.musnix.nixosModules.musnix # bring into scope

    (mkFeature "renoise" "Enable Renoise DAW and VSTs" {
      # set up for realtime
      musnix = {
        enable = true;
        rtcqs.enable = true;
        das_watchdog.enable = true; # prevent realtime hangs?
      };

      environment.systemPackages = with pkgs; [
        ## Custom
        renoise-custom
        # din-is-noise
        lsp-plugins

        ## Synths
        bespokesynth
        pkgs-stable.surge-XT
        pkgs-stable.zynaddsubfx
        geonkick
        # vcv-rack
        dexed
        ams
        bristol
        vital

        ## Daws
        reaper

        ## Tools
        mpg123
        rubberband
      ];
    })
  ];
}
