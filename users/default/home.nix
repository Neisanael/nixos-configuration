{ config, pkgs, lib, inputs, ... }:

{
  home.username = "shiyaken";
  home.homeDirectory = "/home/shiyaken";

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    wireshark
    firefox
    vscode-fhs
    vlc
    blender
    scrcpy
    gimp
    inkscape
    libreoffice
    krita
    kicad
    fritzing
    netbeans
    android-studio
    (discord.override {withTTS = true;})
    telegram-desktop
    zotero
    obs-studio
    audacity
    audacious
    wpsoffice
    handbrake
    arduino
    github-desktop
    staruml
    unityhub
    gns3-gui
    ferdium
    floorp 
  ];

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
  
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };  

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
    
}
