{ pkgs, ... }:
{
  services = {
    printing = {
      enable = true;
      drivers = [
        pkgs.cups-filters
        pkgs.cups-browsed
        pkgs.brlaser
      ];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = true;
  };

  environment.systemPackages = with pkgs; [
    brlaser
  ];
}
