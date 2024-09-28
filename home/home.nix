{config, pkgs, ...}:

{
  imports = [
    ./programs/git.nix
    ./programs/tmux.nix
    ./programs/nvim.nix
    ./programs/zoxide.nix
    ./programs/zsh.nix
  ];

  home.username = "sire_n1chaulas";
  home.homeDirectory = "/home/sire_n1chaulas";

  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    discord
    bitwarden
    xclip
    wine
  ];

  programs = {
    home-manager.enable = true;
    btop.enable = true;
    ripgrep.enable = true;
  };

}
