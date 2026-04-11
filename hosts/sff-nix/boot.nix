{ pkgs, ... }:
{
  imports = [ ../../modules/core/boot.nix ];
  boot = {
    kernelParams = [
      "pcie_aspm=off"
    ];
  };
}
