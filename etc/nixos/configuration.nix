# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’). 

{ config, pkgs, lib, ... }:

# let
#   unstable-pkgs = import <nixpkgs-unstable> { config.allowUnfree = true; };
# in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #      <home-manager/nixos>
    ];
  nix.extraOptions = ''
    experimental-features = nix-command
  '';

  # Enabling Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #ntfs support
  boot.supportedFilesystems = [ "ntfs" ];
  #boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

  # Nix Alternatives Cache
  nix.settings.substituters = [ "https://aseipp-nix-cache.global.ssl.fastly.net" ];

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };


  boot = {
    # kernelPackages = pkgs.linuxKernel.kernels.linux_zen;
    # Kernel for handling heavy workload
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 35;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 20;
        # backgroundColor = "#000000";
      };
    };
  };

  #  specialisation = {
  #    wayland.configuration = {
  #      system.nixos.tags = [ "wayland" ];
  #      xdg.portal = {
  #        enable = true;
  #        wlr.enable = true;
  #        extraPortals = with pkgs; [
  #          xdg-desktop-portal-gnome # More Portal backends for apps like chrome ?
  #          xdg-desktop-portal-gtk
  #        ];
  #      };
  #      environment.sessionVariables = {
  #        NIXOS_OZONE_WL = "1"; # Wayland
  #      };
  #      security.pam.services.hyprland.enableGnomeKeyring = true;
  #      nixpkgs.config.chromium.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
  #      programs.hyprland = {
  #        enable = true;
  #        enableNvidiaPatches = true;
  #        xwayland.enable = true;
  #      };
  #      services = {
  #        xserver = {
  #          enable = true;
  #          displayManager = {
  #            sddm.enable = true;
  #            sddm.wayland.enable = true;
  #            defaultSession = "hyprland";
  #          };
  #          desktopManager = {
  #            plasma5.enable = true;
  #            #gnome.enable = true;
  #          };
  #        };
  #      };
  #    };
  #    xorg.configuration = {
  #      system.nixos.tags = [ "xorg" ];
  #      services = {
  #        xserver = {
  #          enable = true;
  #          displayManager = {
  #            sddm.enable = true;
  #            # sddm.wayland.enable = lib.mkForce false;
  #            #defaultSession = "plasmawayland";
  #            defaultSession = "plasma";
  #          };
  #          desktopManager = {
  #            plasma5.enable = true;
  #          };
  #        };
  #      };
  #    };
  #  };

  # ------------------- Temporary Config until nixos-rebuild has specialisation option in it 

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      #xdg-desktop-portal-gnome # More Portal backends for apps like chrome ?
      # xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Wayland
  };
  security.pam.services.hyprland.enableGnomeKeyring = true;
  nixpkgs.config.chromium.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
  programs.hyprland = {
    enable = true;
    # enableNvidiaPatches = true;
    xwayland.enable = true;
  };



  # services.jupyter.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services = {
    blueman.enable = true;
    displayManager = {
      sddm.enable = true;
      sddm.wayland.enable = true;
      defaultSession = "hyprland";
    };
    xserver = {
      enable = true;
      # upscaleDefaultCursor = true;
      desktopManager = {
        plasma5.enable = true;
        gnome.enable = true;
      };
      windowManager.i3 =
        {
          enable = true;
          extraPackages = with pkgs; [
          ];
        };

      windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
          luarocks # is the package manager for Lua modules
          luadbi-mysql # Database abstraction layer
        ];
      };
      videoDrivers = [
        # "modesetting"
        "nvidia"
      ];
      # deviceSection = ''
      #   DRI
      #   crocus
      # '';
    };
  };

  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";

  # ------------------------------------------------

  # --- Start Accelerated Video Playback Config --------------------------------------------------------------------------------------



  hardware.graphics = {
    enable = true;
    # Vulkan
    # driSupport = true;
    enable32Bit = true;
    # driSupport32Bit = true;   // Previous 24.04 option
    extraPackages = with pkgs; [
      # pkgs.mesa.drivers

      #vulkan-validation-layers
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      # For Broadwell (2014) & newer
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      # Intel Video Acceleration API (VA-API)
      vaapiVdpau
      libvdpau-va-gl

      libvdpau
      # Video Decode & Presentation API for Unix (VDPAU)
      libva
      # GMA 4500 (2008) upto Coffee Lake (2017)
      #linux-firmware
      # Required for Intel Skylake (2015 - 6th Gen) and up

      nvidia-vaapi-driver
      # For Nvidia
      # egl-wayland
      # Nvidia wants people to use this ?
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "i965"; # Previous was iHD
    #NIXOS_OZONE_WL = "1";          # Wayland
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  # --- End Accelerated Video Playback Config --------------------------------------------------------

  # hardware.nvidiaOptimus.disable = true;

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    # Open drivers (NVreg_OpenRmEnableUnsupportedGpus=1)
    open = false;
    # nvidia-drm.modeset=1
    # modesetting.enable = false; # Messes up with x11 but helps with wayland screen tearing eg: sway
    # Allow headless mode
    nvidiaPersistenced = false;
    # NVreg_PreserveVideoMemoryAllocations=1
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      sync.enable = false;
      #reverseSync.enable = true;
    };
  };


  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    enableIPv6 = false;
  };


  # Cloudflare-warp 
  # networking.wg-quick.interfaces = {
  #   wgcf = {
  #     configFile = "/etc/wireguard/wgcf.conf";
  #     autostart = true;
  #   };
  # };



  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # Set your time zone.
  time.timeZone = "Asia/Kathmandu";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";


  services = {
    gnome.gnome-keyring.enable = true;
    auto-cpufreq.enable = false;
    power-profiles-daemon.enable = false;

    tlp = {
      enable = true;
      settings = {
        TLP_DEFAULT_MODE = "AC";
        TLP_PERSISTENT_DEFAULT = 0;

        #CPU_SCALING_GOVERNOR_ON_AC = "performance";    powersave is an alternative option
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "performance";

        #CPU_ENERGY_PERF_POLICY_ON_AC = "performance";    power is an alternative option
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 80;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 50;

        CPU_BOOST_ON_AC = 0;
        CPU_BOOST_ON_BAT = 0;

        # sudo tlp-stats -p
        CPU_SCALING_MIN_FREQ_ON_AC = 800000;    # Min = 800000
        CPU_SCALING_MAX_FREQ_ON_AC = 2000000;   # Max = 4100000

        CPU_SCALING_MIN_FREQ_ON_BAT = 800000;
        CPU_SCALING_MAX_FREQ_ON_BAT = 2000000;

        # sudo tlp-stats -g
        INTEL_GPU_MIN_FREQ_ON_AC = 0;
        INTEL_GPU_MIN_FREQ_ON_BAT = 0;  # Min = 350

        INTEL_GPU_MAX_FREQ_ON_AC = 500;
        INTEL_GPU_MAX_FREQ_ON_BAT = 500;  # Max = 1100

        INTEL_GPU_BOOST_FREQ_ON_AC = 500;
        INTEL_GPU_BOOST_FREQ_ON_BAT = 500;

        USB_AUTOSUSPEND = 0;
        USB_EXCLUDE_AUDIO = 1; # Exclude Audio Devices from Auto Suspend mode
        USB_EXCLUDE_BTUSB = 1; # Same as above for Bluetooth Devices
        USB_EXCLUDE_PRINTER = 1; # Same as above for printers
        USB_EXCLUDE_WWAN = 1;
        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "off";
        SOUND_POWER_SAVE_ON_AC = 0;
        SOUND_POWER_SAVE_ON_BAT = 0;

        #Optional helps save long term battery health
        #START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
        #STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
      };
    };


  };



  services.cloudflare-warp.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11


  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.xserver = {
    xkb = {
      variant = "";
      layout = "us";
    };
  };
  services.libinput.enable = true;

  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
    # Keep the laptop on when lid is closed
    LidSwitchIgnoreInhibited=no
  '';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.coldbrewrosh = {
    isNormalUser = true;
    description = "coldbrewrosh";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      firefox
      firefox-beta
    ];
    shell = pkgs.zsh;
  };

  # Enabling zsh as the default shell for all users instead of bash
  programs.zsh.enable = true;
  #users.defaultUserShell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow Unsupported System's Packages
  # nixpkgs.config.allowUnsupportedSystem = true;

  nixpkgs.config.qt5 = {
    enable = true;
    platformTheme = "qt5ct";
    style = {
      package = pkgs.utterly-nord-plasma;
      name = "Utterly Nord Plasma";
    };
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget

  nixpkgs.config.permittedInsecurePackages = [
    "electron-29.4.6"
  ];

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [

    # --- Pre-reqs ---
    git
    unzip
    unzipNLS
    gnumake
    cmake
    cargo
    # electron_29
    clang-tools_12
    llvmPackages_12.clang-unwrapped
    # nodePackages.pyright

    # --- Normal Packages ---
    kitty
    alacritty
    tmux
    starship # Cross-Shell Prompt ?
    bar # Console Progress Bar
    google-chrome
    chromium
    vlc
    discord
    ranger
    #gnome.nautilus  # Gnome File Manager
    obs-studio
    libreoffice
    zoom-us
    whatsapp-for-linux

    # --- Dev Tools ---
    vim
    helix
    #vscode
    #vscode-fhs
    #vscodium
    #vscodium-fhs
    #neovide
    #	xclip       # Only works in X11 & Not in Wayland
    wl-clipboard # Works in Wayland
    grim
    slurp
    lazygit
    nodejs_22
    nodePackages_latest.live-server
    #corepack_21     # Wrappers for npm, pnpm and Yarn via Node.js Corepack
    nodePackages.pnpm
    # python39
    python312
    python312Packages.django
    pipenv
    luajitPackages.luarocks
    stylua

    # --- QOL ---
    qalculate-qt
    kdePackages.okular

    # --- Extras ---
    gparted
    neofetch

    # --- Customization ---
    nordic
    whitesur-cursors
    numix-icon-theme-circle

    # --- Analysis Tools --- #
    htop
    btop
    powertop # powertop
    du-dust # dust
    vulkan-tools # vulkaninfo --summary
    intel-gpu-tools # sudo intel_gpu_top

    # --- XDG --- #
    xdg-desktop-portal
    #xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    wayland
    xwayland
    cliphist # Wayland Clipboard Manager

    # --- Gnome Tiling reqs --- #
    gnomeExtensions.pop-shell
    gnomeExtensions.tiling-assistant
    gnomeExtensions.just-perfection
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnome-extension-manager
    gnome-tweaks

    # --- Hyprland reqs --- #
    gnome-keyring # Makes Password available to other apps
    # Leave the default keyring blank on first startup ( FOR PERSONAL )
    # Enter a strong passcode for default keyring ( FOR WORK )
    seahorse # Manages Encryption keys & passcodes
    polkit
    polkit_gnome # Authentication Agent
    #libsForQt5.polkit-kde-agent
    libsForQt5.qt5.qtwayland
    libsForQt5.qt5ct
    qt6.qtwayland # QT6 ?
    wlogout # Logout
    rofi-wayland # App Search
    networkmanagerapplet # Wlan
    iwd # Wlan
    #nwg-look         # Theme
    hyprpaper # Wallpaper
    #xfce.xfce4-power-manager    # Power Button
    #swayosd          # Keyboard Shortcuts
    tlp # CPU Frequency & Battery
    #auto-cpufreq
    brightnessctl # Brightness
    #pulseaudio
    pavucontrol
    #eww-wayland # eww bar
    ags
    libdbusmenu-gtk3
    libdbusmenu
    gtk3
    gtkd
    adw-gtk3
    gjs
    orchis-theme
    slurp

    # --- Notification Daemon --- #
    dunst
    mako
    #dbus
    #xorg.libXinerama
    #xorg.libXrandr
    #xprintidle-ng
    #glib



    # --- Hardware Acceleration --- #
    ffmpeg
    #libav

  ];
  # ++ (with unstable-pkgs; [
  #   #alacritty # <---- put your unstable package here
  #   zed-editor
  #   obsidian
  #   vscode
  #   vscodium
  # ]);

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    victor-mono
    jetbrains-mono
    nerdfonts
    # font-awesome
    # google-fonts
    fira-code
    fira-code-symbols
    #dejavu_fonts
    meslo-lg

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 5173 5174 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;



  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
