{ config, pkgs, user, ... }:

{
  ## pipewire ##

  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    
    jack.enable = true;
  };

  ## mpd ##

  # services.mpd = {
  #   enable = true;
  #   user = "${user}";
  #   extraConfig = ''
  #     # music dir
  #     music_directory   "~/Music/library"

  #     # prevent mpd from suddenly resuming
  #     restore_paused    "yes"

  #     # pipewire output
  #     audio_output {
  #       type "pipewire"
  #       name "My PipeWire output"
  #     }
  #   '';
  # };
  # # mpd pipewire workaround (https://nixos.wiki/wiki/MPD)
  # systemd.services.mpd.environment = {
  #   XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.${user}.uid}";
  # };

  # environment.systemPackages = with pkgs; [ mpc ];
}
