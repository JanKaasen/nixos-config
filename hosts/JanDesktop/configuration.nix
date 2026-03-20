{ config, pkgs, inputs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader / Secure Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.lanzaboote = {
  #  enable = true;
  #  pkiBundle = "/etc/secureboot";
  #};

  # Networking
  networking.hostName = "JanDesktop";
  networking.networkmanager.enable = true;

  # Locale
  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "en_US.UTF-8";

  # Allow unfree packages (Discord, Spotify)
  nixpkgs.config.allowUnfree = true;

  # NVIDIA
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
      extraPackages = with pkgs; [
    nvidia-vaapi-driver
  ];
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

    environment.sessionVariables = {
        LIBGL_ALWAYS_SOFTWARE = "0";
        NIXOS_OZONE_WL = "1";
    };
  

  # Steam
  programs.steam.enable = true;
  programs.gamemode.enable = true;

  # Docker
  virtualisation.docker.enable = true;

  # SSH
  services.openssh.enable = true;

  programs.nix-ld = {
  enable = true;
  libraries = with pkgs; [
    libglvnd
    libGL
    xorg.libX11
    xorg.libXcursor
    xorg.libXext
    xorg.libXrandr
    xorg.libXxf86vm
    xorg.libXinerama
    xorg.libXi
    libxkbcommon
    alsa-lib
    openal
    udev
  ];
};

  programs.xwayland.enable = true;

  # User
  users.users.Jan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    sbctl
    libglvnd
    vulkan-tools
  ];

  programs.zsh.enable = true;

  system.stateVersion = "25.11";
}
