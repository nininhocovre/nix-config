{ inputs, ... }:
{
  flake.modules.nixos.hyprland = { pkgs, ... }: {
    home-manager.sharedModules = [ inputs.self.modules.homeManager.hyprland ];

    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };

    systemd.user.services.hyprpolkitagent = {
      description = "Hyprpolkitagent - Polkit authentication agent";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
    services.displayManager.defaultSession = "hyprland";

    programs.hyprland = {
      enable = true;
    };
  };

  flake.modules.homeManager.hyprland =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      imports = with inputs.self.modules.homeManager; [
        catppuccin-light
        wlogout
        hypridle
        hyprlock
        noctalia
      ];

      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
        ];
        xdgOpenUsePortal = true;
        configPackages = [ config.wayland.windowManager.hyprland.package ];
        config.hyprland = {
          default = [
            "hyprland"
            "gtk"
          ];
          "org.freedesktop.impl.portal.OpenURI" = "gtk";
          "org.freedesktop.impl.portal.FileChooser" = "gtk";
          "org.freedesktop.impl.portal.Print" = "gtk";
        };
      };

      home.packages = with pkgs; [
        hyprpicker
        cliphist
        wf-recorder
        grimblast
        slurp
        swappy
        libnotify
        brightnessctl
        networkmanagerapplet
        pamixer
        pavucontrol
        playerctl
        wtype
        wl-clipboard
        xdotool
        yad
      ];

      xdg.configFile."hypr/icons" = {
        source = ./icons;
        recursive = true;
      };

      home.file.".local/share/hypr/stubs".source = "${pkgs.hyprland}/share/hypr/stubs";

      wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        systemd = {
          enable = true;
          variables = [ "--all" ];
        };

        configType = "lua";
        extraLuaFiles = {
          animation = ./lua/animation.lua;
          autostart = ./lua/autostart.lua;
          config = ./lua/config.lua;
          envs = ./lua/envs.lua;
          keys = ./lua/keys.lua;
          window_rules = ./lua/window_rules.lua;
          workspace = ./lua/workspace.lua;
        };
      };
    };
}
