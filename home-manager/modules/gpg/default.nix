{ pkgs, ... }:

{
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-rofi;
    enableSshSupport = true;
    defaultCacheTtl = 28800;
    defaultCacheTtlSsh = 28800;
    maxCacheTtl = 28800;
    maxCacheTtlSsh = 28800;
  };

  programs.gpg = {
    enable = true;
  };
}
