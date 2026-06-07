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
        # ../../../../modules/core/network.nix NEED MIGRATE
        #../../modules/core/dns.nix
        # ../../../../modules/core/nh.nix  NEED MIGRATE
        packages
        printer
        # ../../../../modules/core/sddm.nix  NEED MIGRATE
        security
        services
        # ../../../../modules/core/syncthing.nix  NEED MIGRATE
        # ../../../../modules/core/system.nix  NEED MIGRATE
        system
        
        # ../../modules/core/flatpak.nix
        # ../../modules/core/virtualisation.nix
        # ../../modules/core/dlna.nix

        netbird
        docker

        # Optional
        # ../../modules/hardware/drives # Automatically mount extra external/internal drives
        # ../../../../modules/hardware/video/${config.hostVariables.videoDriver}.nix # Enable gpu drivers defined in variables.nix
        # ../../../../modules/desktop/${vars.desktop} # Set window manager defined in variables.nix  NEED MIGRATE
        # ../../../../modules/programs/terminal/${vars.terminal} # Set terminal defined in variables.nix  NEED MIGRATE
        # ../../../../modules/programs/editor/${vars.editor} # Set editor defined in variables.nix  NEED MIGRATE
        # ../../../../modules/programs/editor/vscode  NEED MIGRATE
        # ../../../../modules/programs/cli/${vars.tuiFileManager} # Set file-manager defined in variables.nix  NEED MIGRATE
        # ../../../../modules/programs/cli/tmux  NEED MIGRATE
        # ../../../../modules/programs/cli/direnv  NEED MIGRATE
        # ../../../../modules/programs/cli/lazygit   NEED MIGRATE
        # ../../../../modules/programs/cli/cava       NEED MIGRATE  
        # ../../../../modules/programs/cli/fastfetch  NEED MIGRATE
        # ../../../../modules/programs/cli/btop    NEED MIGRATE
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