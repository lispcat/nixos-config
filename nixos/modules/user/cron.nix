{ ... }:

{
  systemd.user = {
    timers = {
      hyprpaper-run = {
        Unit = {
          Description = "Exec hyprpaper_run.sh script every hour";
        };
        Timer = {
          OnCalendar = "hourly";
          Persistent = false; # skip missed jobs
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
    };
  };
}
