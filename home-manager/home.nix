
{ config, pkgs, inputs, ... }:
let
  wallpaperPath = "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
  ###
  ## Aliases
  aliases = {
    a = "tmux a || tmux";
    la = "ls -ahl -v --group-directories-first";
    l = "ls -ahl -v --group-directories-first";
    sys-update = "sudo apt update && sudo apt upgrade && sudo apt autoremove";
    update = "home-manager switch";
    ed = "emacsclient -a 'emacs'";
    med = "emacs -q -l ~/.config/minemacs.el";
    qed = "emacsclient -nw -a 'emacs -nw'";
    sued = "sudoedit";
    clean = "(yes | rm /tmp/* -r) & nix-collect-garbage";
    run = "nix-shell -p";
    shl = "nix-shell . --command \"zsh\"";
    shell = "nix-shell . --command \"zsh\" || nix develop";
    poweroff = "sudo poweroff";
    reboot = "sudo reboot";
    ytmp3 = ''yt-dlp -f bestaudio --extract-audio --audio-format mp3 --output "%(title)s.%(ext)s"'';
  };
  ###
  ## Session Vars
  SessionVariables = {
    EDITOR = "emacsclient -a 'emacs'";
  };
in
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];
  home.username = "dgc";
  home.homeDirectory = "/home/dgc";


  home.stateVersion = "23.11"; # Please read the comment before changing.
  nixpkgs.config.allowUnfree = true;
  targets.genericLinux.enable = true;

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    vesktop
    thunderbird
    whatsapp-for-linux
    veracrypt
    sqlitebrowser
    gimp
    mypaint

    libreoffice-qt
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US

    ffmpeg
    yt-dlp

    vlc
    fontfinder

    ## utils

    moreutils
    #file
    killall
    fd
    llvmPackages_12.clang-tools
    #binutils

    # gcc
    # gnumake
    # these should be there system wide ngl
    ## more stuff here

    ## required packages
    gtk3
    dconf
    nitrogen
  ];

  home.sessionVariables = SessionVariables;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  #####
  ###
  ## Alacritty
  home.file.".config/alacritty/alacritty.yml".text = with config.colorScheme.palette; ''
    font:
      size: 14.5
    colors:
      bright:
        black: "0x${base00}"
        blue: "0x${base0D}"
        cyan: "0x${base0C}"
        green: "0x${base0B}"
        magenta: "0x${base0E}"
        red: "0x${base08}"
        white: "0x${base06}"
        yellow: "0x${base09}"
      cursor:
        cursor: "0x${base06}"
        text: "0x${base06}"
      normal:
        black: "0x${base00}"
        blue: "0x${base0D}"
        cyan: "0x${base0C}"
        green: "0x${base0B}"
        magenta: "0x${base0E}"
        red: "0x${base08}"
        white: "0x${base06}"
        yellow: "0x${base0A}"
      primary:
        background: "0x${base00}"
        foreground: "0x${base06}"
    window:
      opacity: 0.95
  '';

  ###
  ## Themes
  #services.xserver.desktopManager.wallpaper.type = "fill";
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
  # Wayland, X, etc. support for session vars
  systemd.user.sessionVariables = SessionVariables;
  ###
  ## xsession
  xsession = {
    enable = true;
    initExtra = ''
      ~/.config/qtile/autostart.sh
    '';
      #xinput set-prop "Logitech G502 HERO Gaming Mouse" "Coordinate Transformation Matrix" 0.5 0 0 0 0.5 0 0 0 1
  };

  ###
  ## Zsh
  programs.zsh = {
    autocd = true;
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = aliases;

    history = {
      size = 1000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    plugins = with pkgs; [
      {
        name = "agkozak-zsh-prompt";
        src = fetchFromGitHub {
          owner = "agkozak";
          repo = "agkozak-zsh-prompt";
          rev = "v3.7.0";
          sha256 = "1iz4l8777i52gfynzpf6yybrmics8g4i3f1xs3rqsr40bb89igrs";
        };
        file = "agkozak-zsh-prompt.plugin.zsh";
      }
      {
        name = "formarks";
        src = fetchFromGitHub {
          owner = "wfxr";
          repo = "formarks";
          rev = "8abce138218a8e6acd3c8ad2dd52550198625944";
          sha256 = "1wr4ypv2b6a2w9qsia29mb36xf98zjzhp3bq4ix6r3cmra3xij90";
        };
        file = "formarks.plugin.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.6.0";
          sha256 = "0zmq66dzasmr5pwribyh4kbkk23jxbpdw4rjxx0i7dx8jjp2lzl4";
        };
        file = "zsh-syntax-highlighting.zsh";
      }
      {
        name = "zsh-abbrev-alias";
        src = fetchFromGitHub {
          owner = "momo-lab";
          repo = "zsh-abbrev-alias";
          rev = "637f0b2dda6d392bf710190ee472a48a20766c07";
          sha256 = "16saanmwpp634yc8jfdxig0ivm1gvcgpif937gbdxf0csc6vh47k";
        };
        file = "abbrev-alias.plugin.zsh";
      }
      {
        name = "zsh-autopair";
        src = fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
          sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
        };
        file = "autopair.zsh";
      }
    ];
    initExtra = ''
    source /etc/profile
    source $HOME/.profile

    # Define key bindings
    bindkey '^o' accept-line
    bindkey '^j' down-line-or-history
    bindkey '^k' up-line-or-history
    bindkey '^p' kill-line


    function enter_nix_shell() {
  if [ -f default.nix ]; then
    echo "Entering nix-shell for $(pwd)"
    nix-shell . --command \"zsh\"
  fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd enter_nix_shell
'';
  };

  ###
  ## Git
  programs.git = {
    # enable = true;
    userName = "Sinthoras39";
    userEmail = "digc0820@gmail.com";
    signing.key = "69E4AF976838CFE7";
    signing.gpgPath = "/usr/bin/gpg";
  };
  ### Rofi
  ##
  home.file.".config/rofi/config.rasi".text = with config.colorScheme.palette; ''
    /*******************************************************************************
    * ROUNDED THEME FOR ROFI
    * User                 : LR-Tech
    * Theme Repo           : https://github.com/lr-tech/rofi-themes-collection
    *******************************************************************************/
    * {
      bg0:    #${base00}F2;
      bg1:    #2A2A2A;
      bg2:    #3D3D3D80;
      bg3:    #F57C00F2;
      fg0:    #E6E6E6;
      fg1:    #${base06};
      fg2:    #969696;
      fg3:    #3D3D3D;
    }

    * {
      font:   "Roboto 12";

      background-color:   transparent;
      text-color:         @fg0;

      margin:     0px;
      padding:    0px;
      spacing:    0px;
  }

  window {
      location:       center;
      width:          480;
      border-radius:  24px;

      background-color:   @bg0;
  }

  mainbox {
      padding:    12px;
  }

  inputbar {
      background-color:   @bg1;
      border-color:       @bg3;

      border:         2px;
      border-radius:  16px;

      padding:    8px 16px;
      spacing:    8px;
      children:   [ prompt, entry ];
  }

  prompt {
      text-color: @fg2;
  }

  entry {
      placeholder:        "Search";
      placeholder-color:  @fg3;
      text-color: @fg1;
  }

  message {
      margin:             12px 0 0;
      border-radius:      16px;
      border-color:       @bg2;
      background-color:   @bg2;
  }

  textbox {
      padding:    8px 24px;
  }

  listview {
      background-color:   transparent;

      margin:     12px 0 0;
      lines:      8;
      columns:    1;

      fixed-height: false;
  }

  element {
      padding:        8px 16px;
      spacing:        8px;
      border-radius:  16px;
  }

  element normal active {
      text-color: @bg3;
  }

  element alternate active {
      text-color: @bg3;
  }

  element selected normal, element selected active {
      background-color:   @bg3;
  }

  element-icon {
      size:           1em;
      vertical-align: 0.5;
  }

  element-text {
      text-color: inherit;
}
  '';
  ###
  ## Redshift
#   home.file.".config/redshift.conf".text = ''
#     [redshift]
#     temp-night=3300
#     gamma=0.8
#     fade=1
#     location-provider=manual
#     adjustment-method=randr

#     [manual]
#     lat=55.7558
#     lon=37.6173
# '';
}
