{ host, pkgs, ... }:
let
  inherit (import ../../hosts/${host}/variables.nix) username;
in
{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 30d --keep 30";
    };
    flake = "/home/${username}/nix-config";
  };

  # environment.systemPackages = with pkgs; [
  #   nix-output-monitor
  #   nvd
  # ];
}
