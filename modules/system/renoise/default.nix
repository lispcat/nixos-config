{ pkgs, pkgs-stable, inputs, mkFeature, ... }:

let
  din-is-noise   = pkgs.callPackage ./din-is-noise { withJack = true; };
  renoise-custom = pkgs.callPackage ./renoise { inherit inputs; };
  lsp-plugins    = pkgs.callPackage ./lsp-plugins {};
  rave-gen-2     = pkgs.callPackage ./rave-generator-2 {};
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
        # rave-gen-2 # gave up, just use yabridge, plsssssssssssssss

        ## Synths
        bespokesynth
        pkgs-stable.surge-XT
        pkgs-stable.zynaddsubfx
        geonkick
        # pkgs-stable.vcv-rack
        dexed
        ams
        bristol
        vital

        ## Daws
        reaper

        ## Tools
        mpg123
        rubberband

        ## VSTs
        metersLv2    # volume analyzer
        guitarix     # distortion pedals
        chow-kick     # classic drum machine
        chow-phaser   # phaser
        stone-phaser  # better phaser
        calf         # set of vst's
        dragonfly-reverb # reverbs
        delayarchitect # nice delay
      ];
    })
  ];
}
