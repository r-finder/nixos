{ config, pkgs, lib, inputs, desktop, ... }:
let 
  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Adwaita'
      gsettings set $gnome_schema color-scheme 'prefer-dark'
    '';
  };

  bmenu = pkgs.writeTextFile {
    name = "bmenu";
    destination = "/bin/bmenu";
    executable = true;
    text = ''
      pkill bemenu
      bemenu-run -i -p 'exec:' --fn 'Sans 12' --line-height 24
    '';
  };
in
{
  imports =
    [ 
      #./sway.nix
      #./hyprland.nix
      ./${lib.strings.toLower desktop}.nix
    ];

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [
      intel-media-driver 
    ];
  };

  fonts.fonts = with pkgs; [
    noto-fonts
    font-awesome
  ];

  sound.enable = true;
  services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
  };  

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_WEBRENDER = "1";
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    MOZ_ENABLE_WAYLAND = "1";
   };

  programs.dconf.enable = true;
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.systemPackages = with pkgs; [
    configure-gtk
    bmenu

    wayland
    xdg-utils 
    glib # gsettings
    gnome3.adwaita-icon-theme  # default gnome cursors
    swaylock
    swayidle
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    bemenu # wayland clone of dmenu
    mako # notification system developed by swaywm maintainer
    wdisplays # tool to configure displays
    kanshi
    alacritty

    zathura
    keepassxc
    pavucontrol
    pinta
  ];  
}