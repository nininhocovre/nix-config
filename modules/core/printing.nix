{ pkgs, ... }:
{
  services = {
    printing = {
      enable = true;
      drivers = [
        # pkgs.hplipWithPlugin
      ];
    };
    # avahi = {
    #   enable = true;
    #   nssmdns4 = true;
    #   openFirewall = true;
    # };
    # ipp-usb.enable = true;
  };

  environment.systemPackages = with pkgs; [
    brlaser
  ];
}
