{ pkgs, ... }:
{
  flake.modules.nixos.sff-nix = {
    boot = {
      kernelParams = [
        "pcie_aspm=off"
      ];
    };
  };
}
