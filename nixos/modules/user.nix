{ pkgs, lib, ... }:

with lib;

{
  programs.zsh.enable = true;

  # Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;

    users.sui = {
      isNormalUser = true;
      description = "sui";
      extraGroups = lib.mkBefore [ "networkmanager" "wheel" ];
      packages = with pkgs; [];
    };
  };
}
