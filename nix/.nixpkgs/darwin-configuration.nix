{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      bat
      config.programs.vim.package
      direnv
      exa
      fd
      fzf
      gh
      gitFull
      gnupg
      google-cloud-sdk
      jq
      neofetch
      nix-direnv
      niv
      nodejs
      pure-prompt
      reattach-to-user-namespace
      ripgrep
      rnix-lsp
      /* starship */
      stow
      tldr
      tmux
      universal-ctags
      urlview
    ];

    loginShell = "${pkgs.zsh}/bin/zsh -l";

    shellAliases = {
      l = "exa -halF";
      cat = "bat";
      find = "fd";
      ls = "exa";
      dre = "vim $HOME/.nixpkgs/darwin-configuration.nix";
      drs = "darwin-rebuild switch";
      gk = "gitk --all --date-order $(git log -g --pretty=%H)";
      vim = "nvim";
    };

    shells = with pkgs; [ bashInteractive zsh ];

    variables = {
      SHELL = "${pkgs.zsh}/bin/zsh";
      LANG = "en_US.UTF-8";
      EDITOR = "vim";
      GOPATH = "$HOME/.go";
      PATH = "$GOPATH/bin:$HOME/.bin:$HOME/.local/bin:$PATH";
      FZF_DEFAULT_COMMAND = "rg --files --hidden --no-ignore-vcs --vimgrep";
      FZF_DEFAULT_OPTS = "--height 50% --layout=reverse --border -m";
    };

    pathsToLink = [ "/share/nix-direnv" ];

    darwinConfig = "$HOME/.nixpkgs/darwin-configuration.nix";
  };

  system = {
    stateVersion = 4;
    defaults = {
      dock = {
        autohide = true;
        mru-spaces = false;
        orientation = "left";
        showhidden = true;
      };

      finder = {
        AppleShowAllExtensions = true;
        QuitMenuItem = true;
        FXEnableExtensionChangeWarning = false;
      };
      NSGlobalDomain = {
        ApplePressAndHoldEnabled = false;
        InitialKeyRepeat = 10;
        KeyRepeat = 1;
        AppleKeyboardUIMode = null;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        _HIHideMenuBar = false;
        NSTableViewDefaultSizeMode = 2;
        AppleShowScrollBars = "Automatic";
        NSUseAnimatedFocusRing = false;
        NSWindowResizeTime = "0.001";
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        PMPrintingExpandedStateForPrint = true;
        PMPrintingExpandedStateForPrint2 = true;
        NSTextShowsControlCharacters = true;
        NSDisableAutomaticTermination = true;
        AppleShowAllExtensions = true;
        "com.apple.mouse.tapBehavior" = null;
        "com.apple.swipescrolldirection" = true;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };

  programs = {
    vim = { package = pkgs.neovim; };

    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };


    zsh = {
      enable = true;
      enableBashCompletion = true;
      enableCompletion = false;
      enableFzfCompletion = true;
      enableFzfGit = true;
      enableFzfHistory = true;
      enableSyntaxHighlighting = true;
    };
  };

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/4b0fe150f81a4eb5dffa0ef2b4069748ab0c4d6c.tar.gz;
    }))
  ];

  services.nix-daemon.enable = true;
}
