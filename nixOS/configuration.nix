# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Additional hardware settings
      ./hardware.nix
    ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader = {
    #systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.xserver = {
    enable = true;
    displayManager.lightdm = {
      enable = true;
      autoLogin = {
        enable = true;
        user = "dgc";
        timeout = 0;
      };
      background = "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
    };
    windowManager.qtile.enable = true;

    layout = "de";
    xkbVariant = "deadacute";
  };

  # Configure console keymap
  console.keyMap = "de";

  security.sudo.wheelNeedsPassword = false;
  services.printing.enable = true;

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  nixpkgs.config.pulseaudio = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # So i can set user shells
  programs.zsh.enable = true;

  users.users.dgc = {
    isNormalUser = true;
    description = "dgc";
    extraGroups = [ "networkmanager" "wheel" "audio"];
    shell = pkgs.zsh;
  };

  users.users.vs = {
    isNormalUser = true;
    description = "vs";
    extraGroups = [ "networkmanager" "audio"];
    shell = pkgs.bash;
  };

  # Install firefox for the case of an emergency (probably just do nix-shell -p firefox)
  # programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";
  services.flatpak.enable = true;
  programs.nix-ld.enable = true;

  # youcan use steam-run
  programs.nix-ld.libraries = with pkgs; [
    # openssl
    # xorg.libX11
    # xorg.libXcursor
    # xorg.libxcb
    # xorg.libXi
    # xorg.libXext
    # xorg.libXrandr
    # libxkbcommon
    # libz
    # libGL
    # vulkan-loader

    # fontconfig
];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pulseaudioFull
    #linuxKernel.packages.linux_xanmod.xone

    python312
    wget
    git
    emacs
    vim # imagine (im just joking)

    gcc
    gnumake

    home-manager
    # Rest should be managed by home-manager
  ];

  # Gaming stuff
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    package = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        libkrb5
        keyutils
      ];
    };
};
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  services.emacs = {
    enable = true;
  };
  fonts.packages = with pkgs; [
    # bront_fonts
    nerdfonts
    whatsapp-emoji-font
    ubuntu_font_family
    noto-fonts-cjk-sans
    noto-fonts
  ];
  fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = ["Ubuntu Bold"];
        serif = ["Ubuntu Bold"];
        monospace = ["Ubuntu Mono"];
      };

      
      hinting.enable = true;
      antialias = true;
  };

  system.stateVersion = "24.05"; # Did you read the comment?

}
