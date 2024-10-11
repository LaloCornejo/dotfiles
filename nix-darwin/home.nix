# home.nix
# home-manager switch

{config, pkgs, ...}:

{
  home.username = "lalocornejo";
  home.homeDirectory = "/Users/lalocornejo";
  home.stateVersion = "24.05";

  home.packages = [

  ];

  home.file = {
    ".zshrc".source = /Users/lalocornejo/.dotfiles/zshrc/.zshrc;
    ".config/nvim".source = /Users/lalocornejo/.dotfiles/nvim;
    ".config/aerospace".source = /Users/lalocornejo/.dotfiles/aerospace;
    ".config/btop".source = /Users/lalocornejo/.dotfiles/btop;
    ".config/fabric".source = /Users/lalocornejo/.dotfiles/fabric;
    ".config/nix".source = /Users/lalocornejo/.dotfiles/nix;
    ".config/nix-darwin".source = /Users/lalocornejo/.dotfiles/nix-darwin;
    ".config/home-manager/home.nix".source = /Users/lalocornejo/.dotfiles/nix-darwin/home.nix;
  };

  home.sessionVariables = {

  };

  home.sessionPath = [
  "/run/current-system/sw/bin"
    "$HOME/.nix-profile/bin"
  ];

  programs.home-manager.enable = true;
  programs.home-manager.path = "$HOME/.config/home-manager";
  programs.bash.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = ''
      # Add any additional configurations here
      export PATH=/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';
  };
}
