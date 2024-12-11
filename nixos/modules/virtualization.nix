{ pkgs, lib, ... }:

{
  # why is it spelled with an s
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
    };
  };

  users.users.sui.extraGroups = [ "libvirtd" ];
  
}
