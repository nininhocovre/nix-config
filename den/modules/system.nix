{
  self,
  inputs,
  pkgs,
  ...
}:
{
  flake.modules.nixos.system = { config, ...}:
    let
      vars = config.hostVariables;
    in
    {
    # imports = [ inputs.nix-index-database.nixosModules.nix-index ];
    programs = {
      # nix-index-database.comma.enable = true;
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
    services.xserver = {
      enable = false;
      excludePackages = with pkgs; [ xterm ];
      exportConfiguration = true; # Make sure /etc/X11/xkb is populated so localectl works correctly
      xkb = {
        layout = "${vars.kbdLayout}";
        variant = "${vars.kbdVariant}";
      };
    };
    nix = {
      # Nix Package Manager Settings
      settings = {
        download-buffer-size = 200000000;
        #auto-optimise-store = true; # May make rebuilds longer but less size
        substituters = [
          "https://cache.nixos.org/"
          "https://nix-community.cachix.org/"
          "https://chaotic-nyx.cachix.org/"
          "https://cachix.cachix.org"
          "https://nix-gaming.cachix.org/"
          # "https://nixpkgs-wayland.cachix.org"
          # "https://devenv.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
          "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
          "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
          # "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
          # "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        ];
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        use-xdg-base-directories = false;
        warn-dirty = false;
        keep-outputs = true;
        keep-derivations = true;
      };
      optimise.automatic = true;
    };
    time.timeZone = "${vars.timezone}";
    i18n.defaultLocale = "${vars.locale}";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "${vars.locale}";
      LC_IDENTIFICATION = "${vars.locale}";
      LC_MEASUREMENT = "${vars.locale}";
      LC_MONETARY = "${vars.locale}";
      LC_NAME = "${vars.locale}";
      LC_NUMERIC = "${vars.locale}";
      LC_PAPER = "${vars.locale}";
      LC_TELEPHONE = "${vars.locale}";
      LC_TIME = "${vars.locale}";
    };
    environment.variables = {
      templates = "${self}/dev-shells";
      NIXOS_OZONE_WL = "1";

      # These are the defaults, and xdg.enable does set them, but due to load
      # order, they're not set before environment.variables are set, which could
      # cause race conditions.
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_BIN_HOME = "$HOME/.local/bin";
    };

    console.keyMap = "${vars.consoleKeymap}";
  };
}
