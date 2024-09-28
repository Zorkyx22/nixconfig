{ config, pkgs,  ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware/hardware-configuration.nix
      ./hardware/nvidia.nix
      ./services/tailscale.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "23.11";
  nix.settings.experimental-features = ["nix-command" "flakes"];
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";
  nixpkgs.config = {
    firefox.enableGnomeExtensions=true;
    allowUnfree=true;
  };

  networking = {
    hostName = "Hive";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 3389 ];
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  virtualisation.docker.enable = true;

  users.users = {
      sire_n1chaulas = 
      let
        homeDir = "/home/sire_n1chaulas";
        sshAuthLocation = homeDir+"/.ssh/authorized_keys";
      in {
        isNormalUser=true;
        description="Nicolas";
        home = homeDir;
        extraGroups=[ "networkmanager" "wheel" "docker"];
        packages = with pkgs; [
          firefox
          ethtool
        #  thunderbird
        ];
        openssh.authorizedKeys.keyFiles=[sshAuthLocation];
    };
      Laurence = 
      let
        homeDir = "/home/Laurence";
        sshAuthLocation = homeDir+"/.ssh/authorized_keys";
      in {
        isNormalUser=true;
        description="Laurence";
        home = homeDir;
        extraGroups=[ "networkmanager" "wheel" "docker"];
        packages = with pkgs; [
          firefox
        ];
        openssh.authorizedKeys.keyFiles=[sshAuthLocation];
    };
  };

 
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [  
      tilix 
      neovim
      git
      gcc
      docker
      ffmpeg
      python3
      pipx
      gnome.gnome-session
      gnome.gnome-remote-desktop
    ];
    localBinInPath = true;
  };
 
  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
    };

    xrdp = {
      enable = true;
      defaultWindowManager = "startplasma-x11";
      openFirewall = true;
    };

    logind = {
      lidSwitchExternalPower = "ignore";
      lidSwitch = "ignore";
      extraConfig = "HandleLidSwitch=ignore";
    };
    
    gnome.gnome-browser-connector.enable = true;

    xserver = {
      enable=true;
      xkb = {
        layout="us";
        variant="";
      };
    };

    displayManager.sddm = {
      enable=true;
      wayland= {
        enable=true;
      };
    };
    desktopManager.plasma6.enable=true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    
    # Disable CUPS to print documents. CVE 2024-something something
    printing.enable = false;


  };

}
