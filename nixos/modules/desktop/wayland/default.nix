{ pkgs, user, ... }:

{
  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd 'zsh -l -c \"/home/${user}/Scripts/dwl-run.sh\"'";
        };
      };
    };
  };

}
