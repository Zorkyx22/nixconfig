{config, pkgs, ...}:

{
  imports = [
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sire_n1chaulas";
  home.homeDirectory = "/home/sire_n1chaulas";

  nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    discord
    bitwarden
    xclip
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Zorkyx22";
    userEmail = "icu.zorkyx@gmail.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
  
  programs.btop.enable = true;
  programs.ripgrep.enable = true;
  
  programs.zsh = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.tmux = {
    enable = true;
    prefix = "C- ";
    mouse = true;
    clock24 = true;
    shell = "\${pkgs.zsh}/bin/zsh";
    extraConfig = "
      set -g base-index 1
      setw -g pane-base-index 1
      run ~/.config/.dotfiles/tmux/plugins/catppuccin/catppuccin.tmux
      bind C-c run \"tmux save-buffer - | xclip -i -sel clip\"
      bind C-v run \"tmux set-buffer $(xclip -o -sel clip); tmux paste-buffer\"
    ";
  };

}
