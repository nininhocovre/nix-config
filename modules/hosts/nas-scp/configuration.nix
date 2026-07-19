{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.nixosConfigurations.nas-scp = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      inputs.self.modules.nixos.nas-scp
    ];
  };

  flake.modules.nixos.nas-scp = {
    imports = with inputs.self.modules.nixos; [
      nasScpHardware

      boot
      hardware
      users
      system

      services
      packages
      security

      intel

      bash
      zsh
      starship

      fonts

      network
      syncthing
      netbird

      nh

      kitty
      nixvim
      yazi
      tmux
      direnv
      lazygit
      fastfetch
      btop
    ];

    networking.hostName = "nas-scp";

    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "25.11"; # Do not change!
  };
}
