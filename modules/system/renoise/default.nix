{ pkgs, pkgs-stable, inputs, mkFeature, ... }:

let
  din-is-noise   = pkgs.callPackage ./din-is-noise { withJack = true; };
  renoise-custom = pkgs.callPackage ./renoise { inherit inputs; };
  lsp-plugins    = pkgs.callPackage ./lsp-plugins {};
  rave-gen-2     = pkgs.callPackage ./rave-generator-2 {};
  ildaeil        = pkgs.callPackage ./ildaeil {};
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
        # lsp-plugins
        # rave-gen-2 # gave up, just use yabridge, plsssssssssssssss
        # ildaeil # gave up, cant get working

        ## Synths
        bespokesynth
        pkgs-stable.surge-XT
        pkgs-stable.zynaddsubfx
        geonkick
        # pkgs-stable.vcv-rack
        cardinal # A BETTER VCV-RACK
        dexed
        ams
        bristol
        vital

        ## yabridge setup
        yabridge
        yabridgectl
        wineWowPackages.stable
        winetricks

        ## Daws
        reaper
        audacity
        # bitwig-studio # proprietary!!!

        ## Tools
        mpg123 # mp3 playing support
        rubberband # timestretching
        qpwgraph # Jack connections interface
        carla # audio plugin host (maybe run Lv2 inside?!?!)

        ## VSTs
        fire               # multi-band distortion
        metersLv2    # volume analyzer (Lv2 format...)
        guitarix     # distortion pedals (jack only?)
        chow-kick     # classic drum generator
        # chow-phaser   # phaser
        stone-phaser  # better phaser
        dragonfly-reverb # reverbs
        delayarchitect # nice delay

        # calf         # set of plugins (no gui, broken, nah)
      ];
    })
  ];
}
