{ config, lib, pkgs, ... }: {
    services = {
      samba = {
        package = pkgs.samba4Full;
        enable = true;
        openFirewall = true;
        shares.testshare = {
          path = "/Data";
          writable = "true";
          comment = "The hive gives and takes...";
        };
        extraConfig = ''
          server smb encrypt = required
          server min protocol = SMB3_00
        '';
      };
