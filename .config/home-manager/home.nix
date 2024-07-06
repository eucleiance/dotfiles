{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "coldbrewrosh";
  home.homeDirectory = "/home/coldbrewrosh";
  home.enableNixpkgsReleaseCheck = false;
  home.pointerCursor.gtk.enable = true;
  home.pointerCursor.package = pkgs.volantes-cursors;
  home.pointerCursor.name = "volantes_light_cursors";
  home = {
    sessionPath = [
      "/home/coldbrewrosh/.local/share/nvim/mason/bin"
    ];
  };
  #home.pointerCursor.x11 = {
  #  enable = true;
  #  defaultCursor = "volantes_light_cursors";
  #};


  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

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
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.hello
    pkgs.dconf
    pkgs.starship

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  #programs.git = {
  #  enable = true;
  #  userName = "coldbrewrosh";
  #  userEmail = "coldbrewrosh@gmail.com";
  #};

  gtk = {
    enable = true;
    theme.package = pkgs.adw-gtk3;
    theme.name = "adw-gtk3";
    cursorTheme.package = pkgs.volantes-cursors;
    cursorTheme.name = "volantes_light_cursors";
    iconTheme.package = pkgs.tela-circle-icon-theme;
    iconTheme.name = "Tela-circle-dark";

  };


  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = false;
    initExtra = '' 
      bindkey '\t' autosuggest-accept
      bindkey '^f' history-incremental-search-backward
      bindkey '^n' expand-or-complete
      bindkey '^p' reverse-menu-complete
      bindkey '^k' up-history
      bindkey '^j' down-history

      export PATH=$PATH:/home/coldbrewrosh/.config/scripts
      export PATH=$PATH:/run/current-system/sw/bin/clangd

      export PNPM_HOME="$HOME/.pnpm"
      export PATH="$PNPM_HOME/bin:$PATH"

      # source /root/.bashrc

      export PNPM_HOME="/root/.local/share/pnpm"
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac

      eval "$(ssh-agent -s)" > /dev/null 2>&1
      ssh-add ~/.ssh/eucleiance > /dev/null 2>&1
      ssh-add ~/.ssh/coldbrewrosh > /dev/null 2>&1


      ltt() {
          tree --gitignore "$@"
      }

      ff() {
          local file
          file=$(fzf --preview="bat --color=always {}")
          if [ -n "$file" ]; then
              # Change directory to the absolute path of the selected file
              cd "$(cd "$(dirname "$file")" && pwd)"
          fi
      }
    '';

    zplug = {
      enable = false;
      plugins = [
        { name = "zthxxx/jovial"; tags = [ as:theme depth:1 ]; }
        #{ name = "heapbytes/heapbytes-zsh"; tags = [ as:theme depth:1 ]; }

      ];
    };


    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";


    #  programs.kitty = {
    #      enable = true;
    #      extraConfig = ''
    #        "font_family FiraCode Nerd Font"\n
    #        "italic_font auto"
    #        '';
    #    };

  }; # zsh settings

  wayland.windowManager.hyprland = {
    #enableNvidiaPatches = true;
    extraConfig = ''test'';
    settings = { };
  };


  programs.waybar = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    settings = { };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      working_directory = "/home/coldbrewrosh/Desktop";
      font.size = 10;
      font.normal.family = "Meslo LGL";
      font.bold.family = "Meslo LGL";
      font.italic.family = "Meslo LGL";
      font.bold_italic.family = "Meslo LGL";
      #window.decorations = "None";
      window.dynamic_padding = true;
      window.padding.x = 1;
      window.padding.y = 0;
      window.opacity = 0.9;
      window.blur = true;
      window.title = "Terminal";
      window.dynamic_title = true;
      window.decorations_theme_variant = "Dark";
      cursor.style.shape = "Beam";
      cursor.style.blinking = "On";
      cursor.vi_mode_style.shape = "Beam";
      cursor.vi_mpde_style.blinking = "On";
      cursor.blink_interval = 500;

    };
  };

  programs.tmux = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.vscode = {
    enable = true;

  };

  #  programs.eww = {
  #    enable = true;
  #"${config.xdg.dataHome}/zsh/history"
  #    configDir = "${config.xdg.configHome}/eww";
  #  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage    
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/coldbrewrosh/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
