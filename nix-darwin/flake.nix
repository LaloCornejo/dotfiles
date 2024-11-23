{
  description = "LÆLÖ Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
 
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager,  ...}:
  let
    configuration = { pkgs, config, ... }: {

    nixpkgs.config.allowUnfree = true;
# List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.neovim
          pkgs.mkalias
          pkgs.direnv
          pkgs.glow
          pkgs.zellij
          pkgs.zoxide
          pkgs.fzf
          pkgs.thefuck
          pkgs.yewtube
          pkgs.yazi
          pkgs.btop
          pkgs.ffmpeg
          pkgs.axel
          pkgs.bat
          pkgs.eza
          pkgs.git
          pkgs.gh
          pkgs.lazygit
          pkgs.nowplaying-cli
          pkgs.karabiner-elements
          pkgs.cmatrix
        ];

        homebrew ={
          enable = true;
          casks = [
            "iina"
            "wireshark"
            "rustdesk"
            "nikitabobko/tap/aerospace"
            "BetterTouchTool"
          ];
          taps = [
            "FelixKratz/formulae"
            "zackelia/formulae"
            "koekeishiya/formulae"
          ];
          brews = [
            "imagemagick"
            "croc"
            "yt-dlp"
            "streamlink"
            "tldr"
            "bclm"
            "node"
            "speedread"
            # "skhd"
          ];
          onActivation.cleanup = "zap";
        };

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
            '';

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "x86_64-darwin";

      users.users.lalocornejo.home = "/Users/lalocornejo";
      nix.configureBuildUsers = true;
      nix.useDaemon = true;

      system.defaults = {
        dock.autohide = true;
        dock.mru-spaces = false;
        finder.AppleShowAllExtensions = true;
        finder.FXPreferredViewStyle = "clmv";
        loginwindow.LoginwindowText = "=^._.^=";
        screencapture.location = "/Users/lalocornejo/Downloads";
        screensaver.askForPasswordDelay = 0;
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Lalos-MacBook-Air
    darwinConfigurations."Lalos-MacBook-Air" = nix-darwin.lib.darwinSystem {
      modules = [ configuration 
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # User owning the Homebrew prefix
            user = "lalocornejo";

            # Automatically migrate existing Homebrew installations
            autoMigrate = true;
          };
        }
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.lalocornejo = import ./home.nix;

          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Lalos-MacBook-Air".pkgs;
  };
}
