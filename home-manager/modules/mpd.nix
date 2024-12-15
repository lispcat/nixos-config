{ ... }:

{
  services = {
    mpd = {
      enable = true;
      musicDirectory = "~/Music/library";
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
  };
}
