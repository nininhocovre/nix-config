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
}
