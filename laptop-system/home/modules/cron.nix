{ pkgs, ... }:

{
  systemd.user = {

    ### Dynamic wallpapers ###
    timers.hyprpaper-run = {
      Unit.Description = "Run hyprpaper update script";
      Install.WantedBy = [ "timers.target" ];

      Timer.OnCalendar = "hourly";
      Timer.Persistent = false;
    };
    services.hyprpaper-run = {
      Unit.Description = "Run hyprpaper update script";

      Service.Type = "oneshot";
      Service.ExecStart = "/home/sui/Scripts/hyprpaper_run.sh -w 5";
    };

    ### Low battery warning ###
    timers.low-bat-warn = {
      Unit.Description = "Low battery warning";
      Install.WantedBy = [ "timers.target" ];

      Timer.OnCalendar = "*:0/5";
      Timer.Persistent = false;
    };
    services.low-bat-warn = {
      Unit.Description = "Low battery warning";
      Service.Type = "oneshot";
      Service.ExecStart = "${pkgs.writeShellScript "low-bat-warn" ''
          level=$(cat /sys/class/power_supply/BAT0/capacity)
          state=$(cat /sys/class/power_supply/BAT0/status)
          if [ "$level" -le 10 ] && [ "$state" = "Discharging" ]; then
            notify-send -t 300000 -u critical "⚠️ Low Battery!" "Battery is at $level%"
          fi
        ''}";
    };
  };
}
