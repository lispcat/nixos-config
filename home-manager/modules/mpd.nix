{ config, user, ... }:

{
  services.mpd = {
    enable = true;
    # considering changing config.xdg.userDirs.music directly? or maybe not?
    musicDirectory = "${config.home.homeDirectory}/Music/library";
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
  home.packages = with pkgs; [ mpc ];
}
