{ pkgs, user, ... }:

{
  services = {
    # wayland greeter
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd '/home/${user}/Scripts/dwl-run.sh'";
        };
      };
    };
  };

  # enable configuring gtk themes in home-manager
  programs.dconf.enable = true;
}
