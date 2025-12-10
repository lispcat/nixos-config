{ mkFeature, ... }:

{
  imports = [
    (mkFeature "laptop-power" "Enable powersaving features" {
      # thermald (prevent overheating)
      services.thermald.enable = true;

      # tlp (power saving)
      services.tlp = {
        enable = true;
        settings = {
          CPU_SCALING_GOVERNOR_ON_AC  = "performance"  ;
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave"    ;
          CPU_ENERGY_PERF_POLICY_ON_AC  = "performance";
          CPU_ENERGY_PERF_POLICY_ON_BAT = "powersave"  ;

          CPU_MIN_PERF_ON_AC = 0;
          CPU_MAX_PERF_ON_AC = 100;
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 20;

          # save long term battery health
          START_CHARGE_THRESH_BAT0 = 70; # start charging at 40 and below
          STOP_CHARGE_THRESH_BAT0  = 90; # stop charging at 95 and above
        };
      };

      services.upower = {
        enable = true;
        criticalPowerAction = "HybridSleep";
      };
    })
  ];
}

