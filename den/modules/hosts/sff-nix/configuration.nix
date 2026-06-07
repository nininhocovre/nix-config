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

  flake.modules.nixos.sff-nix =
    { self, lib, config, ... }:
    # let
    #   vars = config.hostVariables;
    # in
    {
      imports = with inputs.self.modules.nixos;
      [
        base
        boot
        sffNixHardware
        users
        # Core Modules (Don't change unless you know what you're doing)
        # ../../../../modules/scripts  NEED MIGRATE
        bash
        zsh
        starship
        fonts
        hardware
        network
        #../../modules/core/dns.nix
        nh
        packages
        printer
        sddm
        security
        services
        syncthing
        system
        
        # ../../modules/core/flatpak.nix
        # ../../modules/core/virtualisation.nix
        # ../../modules/core/dlna.nix

        netbird
        docker

        # Optional
        # ../../modules/hardware/drives # Automatically mount extra external/internal drives
        nvidia
        # ../../../../modules/desktop/${vars.desktop} # Set window manager defined in variables.nix  NEED MIGRATE
        kitty
        nixvim # investigate too big
        vscode
        yazi
        tmux
        direnv
        # ../../../../modules/programs/cli/lazygit   NEED MIGRATE
        # ../../../../modules/programs/cli/cava       NEED MIGRATE  
        # ../../../../modules/programs/cli/fastfetch  NEED MIGRATE
        btop
        # ../../../../modules/programs/media/discord   NEED MIGRATE
        # ../../../../modules/programs/media/spicetify  NEED MIGRATE
        # ../../modules/programs/media/youtube-music
        # ../../modules/programs/media/thunderbird
        # ../../modules/programs/media/obs-studio
        # ../../../../modules/programs/media/mpv  NEED MIGRATE
        cpuScaler
        thunar
        #../../modules/programs/misc/lact # GPU fan, clock and power configuration
        print3d
      ];
      # ++ lib.optional (vars.games == true) ../../../../modules/core/games.nix;  NEED MIGRATE

      nixpkgs.config.allowUnfree = true;
      system.stateVersion = "25.11"; # Do not change!
    };
}