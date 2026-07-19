{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.nixosConfigurations.sff-nix = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      inputs.self.modules.nixos.sff-nix
    ];
  };

  flake.modules.nixos.sff-nix = {
    imports = with inputs.self.modules.nixos; [
      sffNixHardware

      boot
      hardware
      users
      system

      sddm
      services
      packages
      security

      bash
      zsh
      starship

      fonts

      network
      syncthing
      netbird

      nh

      printer
      print3d

      nvidia

      hyprland

      kitty
      nixvim # investigate too big
      vscode
      yazi
      tmux
      direnv
      lazygit
      cava
      fastfetch
      btop

      discord
      spotify
      # youtube-music
      mpv

      cpuScaler

      thunar

      games
    ];

    networking.hostName = "sff-nix";

    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "25.11"; # Do not change!
  };
}
