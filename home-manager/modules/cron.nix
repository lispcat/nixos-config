{ pkgs, ... }:

{
  systemd.user = {

    ### Dynamic wallpapers ###
    timers.hyprpaper-run = {
      Unit = {
        Description = "Run hyprpaper update script";
      };
      Timer = {
        OnCalendar = "hourly";
        Persistent = false;
      };
      Install = {
        WantedBy = [ "timers.target" ];
      };
    };
    services.hyprpaper-run = {
      Unit = {
        Description = "Run hyprpaper update script";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "/home/sui/Scripts/hyprpaper_run.sh -w 5";
      };
    };

    ### Low battery warning ###
    timers.low-bat-warn = {
      Unit = {
        Description = "Low battery warning";
      };
      Timer = {
        OnCalendar = "*:0/5";
        Persistent = false;
      };
      Install = {
        WantedBy = [ "timers.target" ];
      };
    };
    services.low-bat-warn = {
      Unit = {
        Description = "Low battery warning";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.writeShellScript "low-bat-warn" ''
          level=$(cat /sys/class/power_supply/BAT0/capacity)
          state=$(cat /sys/class/power_supply/BAT0/status)
          if [ "$level" -le 10 ] && [ "$state" = "Discharging" ]; then
            notify-send -t 300000 -u critical "⚠️ Low Battery!" "Battery is at $level%"
          fi
        ''}";
      };
    };

  };
}
