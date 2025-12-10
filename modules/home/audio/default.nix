{ pkgs, config, mkFeature, ... }:

{
  imports = [
    (mkFeature "mpd" "Enable mpd service" {
      home.packages = with pkgs; [ mpc ];

      services = {
        # use 'systemctl --user' to interact
        mpd = {
          enable = true;
          # considering changing config.xdg.userDirs.music directly?
          musicDirectory =
            "${config.home.homeDirectory}/Music/library";
          extraConfig = ''
            # prevent mpd from suddenly resuming
            restore_paused    "yes"

            # pipewire output
            audio_output {
              type "pipewire"
              name "My PipeWire output"
            }
          '';
        };

        mpdris2 = {
          enable = true;
          multimediaKeys = true;
          notifications = true;
        };
      };
    })
  ];
}
