{ ... }:

{
  services = {
    mpd = {
      enable = true;
      extraConfig = ''
        # music dir
        music_directory   "~/Music/library"

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
