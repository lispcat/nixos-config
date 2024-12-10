{ config, ... }:

{
  hardware.pulseaudio.enable = false;
  # sound.enable = true; # deprecated

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    
    jack.enable = true;
  };

  services.mpd = {
    enable = true;
    extraConfig = ''
audio_output {
  type "pipewire"
  name "My PipeWire output"
}
'';
  };
  # mpd pipewire workaround (https://nixos.wiki/wiki/MPD)
  services.mpd.user = "sui";
  systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.sui.uid}";
  };
}
