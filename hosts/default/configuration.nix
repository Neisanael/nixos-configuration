{ config, pkgs, inputs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.efi.efiSysMountPoint = "/mnt/esp";  # Mount point dari ESP
  
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # boot.loader.grub.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.configurationLimit = 5;
  # boot.loader.timeout = 10;
  # boot.loader.grub.splashMode = "stretch";
  # boot.loader.grub.device = "nodev";
  # boot.loader.grub.useOSProber = true;
  # boot.loader.grub.splashImage = ./boot-wallpaper2.png;

  boot.supportedFilesystems = [ "ntfs" ];
  # boot = {
  #  consoleLogLevel = 0;
  #  initrd.verbose = false;
  #  plymouth.enable = true;
  #  kernelParams = [ "quiet" "splash" "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3" "boot.shell_on_fail" ];
  #};

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "id_ID.UTF-8";
    LC_IDENTIFICATION = "id_ID.UTF-8";
    LC_MEASUREMENT = "id_ID.UTF-8";
    LC_MONETARY = "id_ID.UTF-8";
    LC_NAME = "id_ID.UTF-8";
    LC_NUMERIC = "id_ID.UTF-8";
    LC_PAPER = "id_ID.UTF-8";
    LC_TELEPHONE = "id_ID.UTF-8";
    LC_TIME = "id_ID.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      gutenprintBin
    ];
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shiyaken = {
    isNormalUser = true;
    description = "Shiyaken";
    extraGroups = [ "networkmanager" "wheel" "docker" "dialout" "adbusers"];
    shell = pkgs.zsh;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "shiyaken" = import ../../users/default/home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    htop
    btop
    gh
    p7zip
    go
    php83
    php83Packages.composer
    python313
    bun
    nodejs
    fastfetch
    rustup
    clang
    llvmPackages.bintools
    gns3-server
    jdk8
    jdk17
    jdk22
    ntfs3g
    dynamips
    qemu
    vpcs
    kitty
    inetutils
    neovim-unwrapped
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  virtualisation.docker.enable = true;

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  services.httpd = {
    enable = true;
    package = pkgs.apacheHttpd;
  };

  services.flatpak.enable = true;
  xdg.portal.enable = true;
  # xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  services.gns3-server = {
    ubridge.package = pkgs.ubridge;
    ubridge.enable = true;
  };

  security.wrappers.ubridge = {
    source = "${pkgs.ubridge}/bin/ubridge";
    capabilities = "cap_net_admin,cap_net_raw=ep";
    owner = "root";
    group = "root";
    permissions = "u+rx,g+rx,o+rx";
  };

  programs.git = {
    package = pkgs.git;
    enable = true;
    config = {
      init.defaultBranch = "main";
    };
  };

  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
  ];

  # programs.hyprland.enable = true;

  programs.adb.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    zsh-autoenv.enable = true;
    syntaxHighlighting.enable = true;
    enableBashCompletion = true;
    ohMyZsh.enable = true;
    ohMyZsh.theme = "fino-time";
  };

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
  # networking.firewall.allowedTCPPorts = [ ... ];
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
