{ config, lib, pkgs, modulesPath, ... }:

{
  boot.supportedFilesystems = [ "ntfs" ];
  fileSystems."/win"=
   { device = "/dev/disk/by-uuid/CCA23B9CA23B8A4A";
     fsType = "ntfs-3g";
     options = [ "rw" "uid=1000" ];
   };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  services.xserver = {
    videoDrivers = ["nvidia"];
    screenSection = ''
      Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
      Option         "AllowIndirectGLXProtocol" "off"
      Option         "TripleBuffer" "on"
    '';
  };

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = false;

    # Enable the Nvidia settings menu,
	  # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # web2gtk bug on nivida :(
  environment.variables = {
    WEBKIT_DISABLE_DMABUF_RENDERER = 1;
  };
}
