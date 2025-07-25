{ ... }:

{
  systemd.user = {
    timers."hyprpaper-run" = {
      WantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "hourly";
        Persistent = false;
      };
      description = "Exec hyprpaper_run.sh script every hour";
    };
    services."hyprpaper-run" = {
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "/home/sui/Scripts/hyprpaper_run.sh";
      };
      description = "Exec hyprpaper_run.sh script every hour";
    };
  };
}
