{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    #obsidian
    #ludusavi # For game saves
    #protonvpn-gui # VPN
    #github-desktop
    # pokego # Overlayed
    # vivaldi
    # vivaldi-ffmpeg-codecs
    (vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
      commandLineArgs = ''
        -enable-features=UseOzonePlatform
        --ozone-platform=wayland
        --ozone-platform-hint=auto
        --enable-features=WaylandWindowDecorations 
      '';
    })
    oscar
    doublecmd
    nextcloud-client
    enpass
    digikam
    freecad
    orca-slicer
    sparrow
    vlc
  ];

  # programs.coolercontrol.enable = true; # need to configure fan curve

  home-manager.sharedModules = [
    (_: {
      xdg.desktopEntries = {
        orca-slicer = {
          name = "Orca Slicer";
          exec = "env __GLX_VENDOR_LIBRARY_NAME=mesa __EGL_VENDOR_LIBRARY_FILENAMES=/run/opengl-driver/share/glvnd/egl_vendor.d/50_mesa.json MESA_LOADER_DRIVER_OVERRIDE=zink GALLIUM_DRIVER=zink WEBKIT_DISABLE_DMABUF_RENDERER=1 orca-slicer";
        };
      };
    })
  ];
}
