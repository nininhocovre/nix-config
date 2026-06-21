{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    freecad
    orca-slicer
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
