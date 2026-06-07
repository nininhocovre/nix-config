{
  # pkgs,
  inputs,
  # host,
  ...
}:
{
  flake.modules.nixos.users = { config, pkgs, ...}:
  let
    vars = config.hostVariables;
  in
  {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    programs.dconf.enable = true; # Enable dconf for home-manager
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      overwriteBackup = true;
      backupFileExtension = "backup";
      users.${vars.username} = {
        # Let Home Manager install and manage itself.
        programs.home-manager.enable = true;
        xdg.enable = true;

        home = {
          username = "${vars.username}";
          homeDirectory = "/home/${vars.username}";
          stateVersion = "25.11"; # Do not change!
          sessionVariables = {
            EDITOR = "nvim";
            BROWSER = "${vars.browser}";
            TERMINAL = "${vars.terminal}";
          };
        };
      };
    };
    users = {
      mutableUsers = true;
      users.${vars.username} = {
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
        shell = pkgs.${vars.shell};
        ignoreShellProgramCheck = true;
      };
    };
    nix.settings.allowed-users = [ "${vars.username}" ];
  };
}
