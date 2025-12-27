{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    #obsidian
    #ludusavi # For game saves
    #protonvpn-gui # VPN
    #github-desktop
    # pokego # Overlayed
    vivaldi
    vivaldi-ffmpeg-codecs
    oscar
    doublecmd
    nextcloud-client
    enpass
    digikam
    freecad
    orca-slicer
    sparrow
    coolercontrol.coolercontrold
    coolercontrol.coolercontrol-gui
  ];

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
