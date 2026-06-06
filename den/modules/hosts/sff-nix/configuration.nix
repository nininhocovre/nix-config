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
      imports = 
      [
        inputs.self.modules.nixos.base
        inputs.self.modules.nixos.print3d
        ../../../../hosts/sff-nix/hardware-configuration.nix
        ../../../../hosts/sff-nix/host-packages.nix

        ../../../../hosts/sff-nix/drive-mount.nix

        # Core Modules (Don't change unless you know what you're doing)
        # ../../../../modules/scripts  NEED MIGRATE
        ../../../../hosts/sff-nix/boot.nix
        # ../../../../modules/core/bash.nix  NEED MIGRATE
        # ../../../../modules/core/zsh.nix  NEED MIGRATE
        # ../../../../modules/core/starship.nix  NEED MIGRATE
        ../../../../modules/core/fonts.nix
        ../../../../modules/core/hardware.nix
        # ../../../../modules/core/network.nix NEED MIGRATE
        #../../modules/core/dns.nix
        # ../../../../modules/core/nh.nix  NEED MIGRATE
        ../../../../modules/core/packages.nix
        ../../../../modules/core/printing.nix
        # ../../../../modules/core/sddm.nix  NEED MIGRATE
        ../../../../modules/core/security.nix
        ../../../../modules/core/services.nix
        # ../../../../modules/core/syncthing.nix  NEED MIGRATE
        # ../../../../modules/core/system.nix  NEED MIGRATE
        inputs.self.modules.nixos.system
        # ../../../../modules/core/users.nix  NEED MIGRATE
        # ../../modules/core/flatpak.nix
        # ../../modules/core/virtualisation.nix
        # ../../modules/core/dlna.nix

        ../../../../modules/core/netbird.nix
        ../../../../modules/core/docker.nix

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
        ../../../../modules/programs/misc/tlp
        ../../../../modules/programs/misc/thunar
        #../../modules/programs/misc/lact # GPU fan, clock and power configuration
        # ../../modules/programs/3dprint
      ];
      # ++ lib.optional (vars.games == true) ../../../../modules/core/games.nix;  NEED MIGRATE

      nixpkgs.config.allowUnfree = true;
      system.stateVersion = "25.11"; # Do not change!
    };
}