{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../modules/desktop/gnome.nix
  ];

  # Bootloader et Kernel
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_6_6;

  # Réseau
  networking.hostName = "laptop-intel"; 
  networking.networkmanager.enable = true;

  # Internationalisation
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Clavier (Important pour ne pas être en QWERTY)
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };

  # Son (Pipewire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Utilisateur
  users.users.hry223 = {
    isNormalUser = true;
    description = "hry223";
    extraGroups = [ "networkmanager" "wheel" "vboxusers" ];
    packages = with pkgs; [
        kdePackages.kate
    ];
  };

  # Graphismes Intel uniquement
  hardware.graphics = {
    enable = true;   
    enable32Bit = true;
  };

  # Paquets système communs
  environment.systemPackages = with pkgs; [
    neovim wget git fastfetch brave steam gcc gnumake tree
  ];

  # Optimisations Nix
  nixpkgs.config.allowUnfree = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  system.stateVersion = "25.11";
}
