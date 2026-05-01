{ host, ... }:
let
  inherit (import ../../hosts/${host}/variables.nix) username;
in
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    guiAddress = "0.0.0.0:8384";

    user = "${username}";
    # dataDir = "/home/${username}";
    configDir = "/home/${username}/.config/syncthing";
  };

  networking.firewall.allowedTCPPorts = [ 8384 ];
}
