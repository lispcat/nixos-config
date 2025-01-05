{ pkgs, user, ... }:

{
  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd 'river > /tmp/river.log 2>&1'";
        };
      };
    };
  };

}
