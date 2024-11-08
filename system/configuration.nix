{ config, pkgs, inputs,  ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      inputs.nix-minecraft.nixosModules.minecraft-servers
      ./hardware/hardware-configuration.nix
      ./hardware/nvidia.nix
      ./services/tailscale.nix
      ./services/kanata.nix
      ./services/cloudflared.nix
      ./services/minecraft-server.nix
      ./services/samba.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  system.stateVersion = "23.11";
  nix.settings.experimental-features = ["nix-command" "flakes"];
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";
  nixpkgs.config = {
    allowUnfree=true;
  };

  networking = {
    hostName = "Hive";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 3389 25565 ];
  };

  virtualisation.docker.enable = true;

  users.users = {
      sire_n1chaulas = {
        isNormalUser=true;
        description="Nicolas";
        home = "/home/sire_n1chaulas";
        extraGroups=[ "networkmanager" "wheel" "docker"];
        packages = with pkgs; [
          ethtool
        ];
      };
  };

 
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [  
      neovim
      git
      gcc
      docker
      cloudflared
      kitty
    ];
    localBinInPath = true;
  };
 
  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
    };

    logind = {
      lidSwitchExternalPower = "ignore";
      lidSwitch = "ignore";
      extraConfig = "HandleLidSwitch=ignore";
    };
    
    # Disable CUPS to print documents. CVE 2024-something something
    printing.enable = false;

  };

}
