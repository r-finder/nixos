{ config, pkgs, inputs, ... }:
{
  # boot.kernelParams = ["intel_pstate=passive"];

  powerManagement.enable = true;
  services.thermald.enable = true; #intel only
  services.tlp = {
    enable = true;
    settings = {
      CPU_DRIVER_OPMODE_ON_AC="passive";
      CPU_DRIVER_OPMODE_ON_BAT="passive";

      CPU_SCALING_GOVERNOR_ON_AC = "conservative";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # CPU_SCALING_MIN_FREQ_ON_AC=0
      # CPU_SCALING_MAX_FREQ_ON_AC=9999999
      # CPU_SCALING_MIN_FREQ_ON_BAT=0
      # CPU_SCALING_MAX_FREQ_ON_BAT=9999999

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 60;

      CPU_BOOST_ON_AC=1;
      CPU_BOOST_ON_BAT=0;

      INTEL_GPU_MAX_FREQ_ON_AC=800; #really 1150
      INTEL_GPU_MAX_FREQ_ON_BAT=800;
      INTEL_GPU_BOOST_FREQ_ON_AC=800;
      INTEL_GPU_BOOST_FREQ_ON_BAT=800;
    };
  };  
}
