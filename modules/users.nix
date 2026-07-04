{
  # pkgs,
  inputs,
  # host,
  ...
}:
{
  flake.modules.nixos.users =
    { config, pkgs, ... }:
    let
      username = "nininho";
    in
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];
      programs.dconf.enable = true; # Enable dconf for home-manager
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        overwriteBackup = true;
        backupFileExtension = "backup";
        users.${username} = {
          # Let Home Manager install and manage itself.
          programs.home-manager.enable = true;
          xdg.enable = true;

          home = {
            username = "${username}";
            homeDirectory = "/home/${username}";
            stateVersion = "25.11"; # Do not change!
            sessionVariables = {
              EDITOR = "nvim";
              TERMINAL = "kitty";
            };
          };
        };
      };
      users = {
        mutableUsers = true;
        users.${username} = {
          isNormalUser = true;
          uid = 1000;
          extraGroups = [
            "wheel" # sudo access
            "input"
            "networkmanager"
            "video"
            "audio"
            "libvirtd"
            "kvm"
            "docker"
            "disk"
            "adbusers"
            "lp"
            "scanner"
            "vboxusers" # Virtual Box
          ];
          shell = pkgs.zsh;
          ignoreShellProgramCheck = true;
        };
      };
      nix.settings.allowed-users = [ "${username}" ];
    };
}
