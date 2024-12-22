{ config, pkgs, lib, ... }:

# with lib;

{
  ## realtime configuration

  users.users.sui.extraGroups = [ "audio" ];

  environment.systemPackages =
    let
      rtcqs = pkgs.callPackage ./rtcqs.nix { };
    in
      [ rtcqs ];

  boot = {
    kernelParams = [ "threadirqs" ];
  };

  environment.sessionVariables =
    let
      makePluginPath =
        format:
        (lib.makeSearchPath format [
          "$HOME/.nix-profile/lib"
          "/run/current-system/sw/lib"
          "/etc/profiles/per-user/$USER/lib"
        ])
        + ":$HOME/.${format}";
    in
      {
        CLAP_PATH = lib.mkDefault (makePluginPath "clap");
        DSSI_PATH = lib.mkDefault (makePluginPath "dssi");
        LADSPA_PATH = lib.mkDefault (makePluginPath "ladspa");
        LV2_PATH = lib.mkDefault (makePluginPath "lv2");
        LXVST_PATH = lib.mkDefault (makePluginPath "lxvst");
        VST3_PATH = lib.mkDefault (makePluginPath "vst3");
        VST_PATH = lib.mkDefault (makePluginPath "vst");
      };

  powerManagement.cpuFreqGovernor = "performance";

  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "-"   ; value = "unlimited"; }
    { domain = "@audio"; item = "rtprio" ; type = "-"   ; value = "99"       ; }
    { domain = "@audio"; item = "nofile" ; type = "soft"; value = "99999"    ; }
    { domain = "@audio"; item = "nofile" ; type = "hard"; value = "99999"    ; }
  ];

  services.udev.extraRules = ''
    KERNEL=="rtc0", GROUP="audio"
    KERNEL=="hpet", GROUP="audio"
    DEVPATH=="/devices/virtual/misc/cpu_dma_latency", OWNER="root", GROUP="audio", MODE="0660"
  '';
  

}
