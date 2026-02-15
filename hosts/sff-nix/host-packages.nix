{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
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
    sparrow
    vlc
  ];

  # programs.coolercontrol.enable = true; # need to configure fan curve
}
