{ pkgs, ... }:

{
  services = {
    # wayland greeter
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd 'dwl -s dwlb &> /tmp/dwl.log'";
        };
      };
    };
  };
}
