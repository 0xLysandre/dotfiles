{ config, pkgs, ... }:

{
  imports = [  
    ./hardware-configuration.nix
    ../../modules/desktop/kde.nix
    ../../modules/hardware/nvidia.nix
    ../../modules/system/fonts.nix  # <-- AJOUTE CETTE LIGNE
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_6_6;

  networking.hostName = "desktop-nvidia";
  networking.networkmanager.enable = true;

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

  # Configuration clavier
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };

  # Configuration Son
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Définition de l'utilisateur (CE QUI MANQUAIT)
  users.users.hry223 = {
    isNormalUser = true;
    description = "hry223";
    extraGroups = [ "networkmanager" "wheel" "vboxusers" ];
    # Optionnel: Créer un groupe personnel pour éviter l'erreur "group is unset"
    group = "users"; 
  };
  
  virtualisation.virtualbox.host.enable = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim wget git gimp home-manager fastfetch lshw brave steam libgcc localsend zig gcc gnumake binutils prismlauncher tree obsidian
  ];

  hardware.graphics = {
    enable = true;    
    enable32Bit = true;
  };

  system.stateVersion = "25.11";
}
