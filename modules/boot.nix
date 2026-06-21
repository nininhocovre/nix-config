{ pkgs, ... }:
{
  flake.modules.nixos.boot = { pkgs, ... }: {
    boot = {
      supportedFilesystems = [
        "ntfs"
        "exfat"
        "ext4"
        "fat32"
        "btrfs"
      ];
      tmp.cleanOnBoot = true;
      kernelPackages = pkgs.linuxPackages; # _latest, _zen, _xanmod_latest, _hardened, _rt, _OTHER_CHANNEL, etc.
      loader = {
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot";
        };
        timeout = 15; # Display bootloader indefinitely until user selects OS
        systemd-boot.enable = true;
      };
    };
  };
}
