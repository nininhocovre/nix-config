{ pkgs, ... }:
{
  boot = {
    # Filesystems support
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
      # grub = {
      #   enable = true;
      #   device = "nodev";
      #   efiSupport = true;
      #   # useOSProber = true;
      #   # extraEntries =
      #   #   ''
      #   #   menuentry "Arch Linux" {
      #   #     insmod all_video
      #   #     set gfxpayload=keep
      #   #     search --no-floppy --fs-uuid  --set=root 231D-E6D2
      #   #     echo 'Loading Kernel: vmlinuz-linux ...'
      #   #     linux "/vmlinuz-linux" root=UUID=78286f55-15cc-4a2e-9300-ff846f6ae48c zswap.enabled=0 rootfstype=btrfs pcie_aspm=off loglevel=3  rootflags=rw,noatime,compress=zstd:3,ssd,discard=async,space_cache=v2,autodefrag,subvol="@"
      #   #     echo 'Loading Initramfs: initramfs-linux.img ...'
      #   #     initrd "/initramfs-linux.img"
      #   #   }
      #   #   '';
      #   gfxmodeEfi = "2715x1527"; # for 4k: 3840x2160
      #   gfxmodeBios = "2715x1527"; # for 4k: 3840x2160
      #   theme = pkgs.stdenv.mkDerivation {
      #     pname = "distro-grub-themes";
      #     version = "3.1";
      #     src = pkgs.fetchFromGitHub {
      #       owner = "AdisonCavani";
      #       repo = "distro-grub-themes";
      #       rev = "v3.1";
      #       hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
      #     };
      #     installPhase = "cp -r customize/nixos $out";
      #   };
      # };
    };
    # Appimage Support
#     binfmt.registrations.appimage = {
#       wrapInterpreterInShell = false;
#       interpreter = "${pkgs.appimage-run}/bin/appimage-run";
#       recognitionType = "magic";
#       offset = 0;
#       mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
#       magicOrExtension = ''\x7fELF....AI\x02'';
#     };
  };
}
