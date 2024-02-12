{
  inputs,
  root,
  ...
}: c: {
  pkgs,
  lib,
  ...
}: {
  imports = with root; [
    (bluetooth {})
    (networking {})
    (pipewire {})
  ];

  # gnome keyring
  services.gnome.gnome-keyring = {
    enable = true;
  };

  # D-Bus
  services.dbus = {
    enable = true;
  };

  # gvfs
  services.gvfs = {
    enable = true;
  };

  # thumbnailer
  services.tumbler = {
    enable = true;
  };

  # power info
  services.upower = {
    enable = true;
  };

  # brightness control
  programs.light = {
    enable = true;
  };

  # D-conf
  programs.dconf = {
    enable = true;
  };

  # desktop
  services.xserver.displayManager.gdm = {
    enable = true;
  };
  services.xserver.windowManager.awesome = {
    enable = true;
    package =
      (pkgs.awesome.overrideAttrs (oa: {
        GI_TYPELIB_PATH = let
          extraGIPackages = with pkgs; [pango.out networkmanager upower playerctl bluez];
          mkGITypeLibPath = pkg: "${pkg}/lib/girepository-1.0";
          extraGITypeLibPaths = lib.forEach extraGIPackages mkGITypeLibPath;
        in
          lib.concatStringsSep ":" extraGITypeLibPaths;
      }))
      .override {
        lua = pkgs.luajit;
        gtk3Support = true;
      };
    luaModules = with pkgs.luajitPackages; [luarocks ldbus cjson stdlib];
  };

  environment.systemPackages = with pkgs; [
    gnome.nautilus
    # libsecret
    # libgnome-keyring
    gnome.seahorse
    networkmanagerapplet
    xclip
  ];
}
