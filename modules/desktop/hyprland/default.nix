{
  host,
  lib,
  pkgs,
  ...
}:
let
  inherit (import ../../../hosts/${host}/variables.nix)
    waybarTheme
    browser
    terminal
    tuiFileManager
    kbdLayout
    kbdVariant
    defaultWallpaper
    ;
in
{
  imports = [
    ../../themes/Catppuccin-light # Catppuccin GTK and QT themes
    #./programs/waybar/${waybarTheme}.nix
    ./programs/wlogout
    #./programs/rofi
    ./programs/hypridle
    ./programs/hyprlock
    #./programs/swaync
    # ./programs/dunst
    ./programs/noctalia
  ];

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

  home-manager.sharedModules =
    let
      inherit (lib) getExe getExe';
    in
    [
      (
        { config, ... }:
        {
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

          #test later systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
          wayland.windowManager.hyprland = {
            enable = true;
            plugins = [
              # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprwinwrap
              # inputs.hyprsysteminfo.packages.${pkgs.stdenv.hostPlatform.system}.default
            ];
            systemd = {
              enable = true;
              variables = [ "--all" ];
            };
            settings = {
              "$mainMod" = "SUPER";
              "$term" = "${getExe pkgs.${terminal}}";
              "$editor" = "code --disable-gpu";
              "$fileManager" = "$term --class \"tuiFileManager\" -e ${tuiFileManager}";
              "$browser" = "vivaldi --enable-features=UseOzonePlatform --ozone-platform=wayland";

              env = [
                "XDG_CURRENT_DESKTOP,Hyprland"
                "XDG_SESSION_DESKTOP,Hyprland"
                "XDG_SESSION_TYPE,wayland"
                "GDK_BACKEND,wayland,x11,*"
                "NIXOS_OZONE_WL,1"
                "ELECTRON_OZONE_PLATFORM_HINT,wayland"
                "MOZ_ENABLE_WAYLAND,1"
                "OZONE_PLATFORM,wayland"
                "EGL_PLATFORM,wayland"
                "CLUTTER_BACKEND,wayland"
                "SDL_VIDEODRIVER,wayland"
                "QT_QPA_PLATFORM,wayland;xcb"
                "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
                "QT_QPA_PLATFORMTHEME,qt6ct"
                "QT_AUTO_SCREEN_SCALE_FACTOR,1"
                "QT_ENABLE_HIGHDPI_SCALING,1"
                "WLR_RENDERER_ALLOW_SOFTWARE,1"
                "NIXPKGS_ALLOW_UNFREE,1"
              ];
              exec-once = [
                "noctalia-shell"
                "nm-applet --indicator"
                # "wl-clipboard-history -t"
                "${getExe' pkgs.wl-clipboard "wl-paste"} --type text --watch cliphist store" # clipboard store text data
                "${getExe' pkgs.wl-clipboard "wl-paste"} --type image --watch cliphist store" # clipboard store image data
                "rm '$XDG_CACHE_HOME/cliphist/db'" # Clear clipboard
                "polkit-agent-helper-1"

                "nextcloud --background"
                "netbird-ui"
                "steam -silent"
                "heroic"
                "Enpass -minimize"
              ];
              input = {
                kb_layout = "${kbdLayout},ru";
                kb_variant = "${kbdVariant},";
                repeat_delay = 275; # or 212
                repeat_rate = 35;
                numlock_by_default = true;

                follow_mouse = 1;

                touchpad.natural_scroll = false;

                tablet.output = "current";

                sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
                force_no_accel = true;
              };
              general = {
                gaps_in = 4;
                gaps_out = 8;
                border_size = 2;
                "col.active_border" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
                "col.inactive_border" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
                resize_on_border = true;
                layout = "dwindle"; # dwindle or master
                # allow_tearing = true; # Allow tearing for games (use immediate window rules for specific games or all titles)
              };
              decoration = {
                shadow.enabled = false;
                rounding = 10;
                dim_special = 0.3;
                blur = {
                  enabled = true;
                  special = true;
                  size = 6; # 6
                  passes = 2; # 3
                  new_optimizations = true;
                  ignore_opacity = true;
                  xray = false;
                };
              };
              group = {
                "col.border_active" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
                "col.border_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
                "col.border_locked_active" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
                "col.border_locked_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
              };
              layerrule = [
              ];
              animations = {
                enabled = true;
                bezier = [
                  "linear, 0, 0, 1, 1"
                  "md3_standard, 0.2, 0, 0, 1"
                  "md3_decel, 0.05, 0.7, 0.1, 1"
                  "md3_accel, 0.3, 0, 0.8, 0.15"
                  "overshot, 0.05, 0.9, 0.1, 1.1"
                  "crazyshot, 0.1, 1.5, 0.76, 0.92"
                  "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
                  "fluent_decel, 0.1, 1, 0, 1"
                  "easeInOutCirc, 0.85, 0, 0.15, 1"
                  "easeOutCirc, 0, 0.55, 0.45, 1"
                  "easeOutExpo, 0.16, 1, 0.3, 1"
                ];
                animation = [
                  "windows, 1, 3, md3_decel, popin 60%"
                  "border, 1, 10, default"
                  "fade, 1, 2.5, md3_decel"
                  # "workspaces, 1, 3.5, md3_decel, slide"
                  "workspaces, 1, 3.5, easeOutExpo, slide"
                  # "workspaces, 1, 7, fluent_decel, slidefade 15%"
                  # "specialWorkspace, 1, 3, md3_decel, slidefadevert 15%"
                  "specialWorkspace, 1, 3, md3_decel, slidevert"
                ];
              };
              render = {
                direct_scanout = 0; # 0 = off, 1 = on, 2 = auto (on with content type ‘game’)
              };
              ecosystem = {
                # no_update_news = true;
                no_donation_nag = true;
              };
              misc = {
                disable_hyprland_logo = true;
                mouse_move_focuses_monitor = true;
                swallow_regex = "^(Alacritty|kitty)$";
                enable_swallow = true;
                vfr = true; # always keep on
                vrr = 2; # enable variable refresh rate (0=off, 1=on, 2=fullscreen only, 3 = fullscreen games/media)
              };
              xwayland.force_zero_scaling = false;
              gesture = [
                "3, horizontal, workspace"
              ];
              dwindle = {
                pseudotile = true;
                preserve_split = true;
              };
              master = {
                new_status = "master";
                new_on_top = true;
                mfact = 0.5;
              };
              windowrule = [
                "tile on, match:title (.*)(Godot)(.*)$"
                "opacity 1.00 1.00, match:class ^(firefox|Brave-browser|floorp|zen|zen-beta)$"
                "opacity 0.90 0.80, match:class ^(Emacs)$"
                "opacity 0.90 0.80, match:class ^(gcr-prompter)$"
                "opacity 0.90 0.80, match:title ^(Hyprland Polkit Agent)$"
                "opacity 0.90 0.80, match:class ^(obsidian)$"
                "opacity 0.90 0.80, match:class ^(Lutris|lutris|net.lutris.Lutris)$"
                "opacity 0.80 0.70, match:class ^(kitty|alacritty|Alacritty|org.wezfurlong.wezterm)$"
                "opacity 0.80 0.70, match:class ^(nvim-wrapper)$"
                "opacity 0.80 0.70, match:class ^(gnome-disks)$"
                "opacity 0.80 0.70, match:class ^(org.gnome.Nautilus|Thunar|thunar|pcmanfm)$"
                "opacity 0.80 0.70, match:class ^(thunar-volman-settings)$"
                "opacity 0.80 0.70, match:class ^(org.gnome.FileRoller)$"
                "opacity 0.80 0.70, match:class ^(io.github.ilya_zlobintsev.LACT)$"
                "opacity 0.80 0.70, match:class ^(Steam|steam|steamwebhelper)$"
                "opacity 0.80 0.70, match:class ^(Spotify|spotify)$"
                "opacity 0.80 0.70, match:title (.*)(Spotify)(.*)$"
                "opacity 0.80 0.70, match:title ^(Kvantum Manager)$"
                "opacity 0.80 0.70, match:class ^(VSCodium|codium-url-handler)$"
                "opacity 0.80 0.70, match:class ^(code|code-url-handler)$"
                "opacity 0.80 0.70, match:class ^(tuiFileManager)$"
                "opacity 0.80 0.70, match:class ^(org.kde.dolphin)$"
                "opacity 0.80 0.70, float on, match:class ^(org.kde.ark)$"
                "opacity 0.80 0.70, float on, match:class ^(nwg-look)$"
                "opacity 0.80 0.70, match:class ^(qt5ct|qt6ct)$"
                "opacity 0.80 0.70, float on, match:class ^(yad)$"
                "opacity 0.90 0.80, match:class ^(discord)$"
                "opacity 0.90 0.80, match:class ^(WebCord)$"
                "opacity 0.90 0.80, float on, match:class ^(com.github.rafostar.Clapper)$"
                "opacity 0.80 0.70, match:class ^(com.github.tchx84.Flatseal)$"
                "opacity 0.80 0.70, match:class ^(hu.kramo.Cartridges)$"
                "opacity 0.80 0.70, match:class ^(com.obsproject.Studio)$"
                "opacity 0.80 0.70, match:class ^(gnome-boxes)$"
                "opacity 0.80 0.70, float on, match:class ^(app.drey.Warp)$"
                "opacity 0.80 0.70, float on, match:class ^(net.davidotek.pupgui2)$"
                "opacity 0.80 0.70, float on, match:class ^(Signal)$"
                "opacity 0.80 0.70, float on, match:class ^(io.gitlab.theevilskeleton.Upscaler)$"
                "opacity 0.80 0.70, float on, match:class ^(pavucontrol)$"
                "opacity 0.80 0.70, match:class ^(org.pulseaudio.pavucontrol)$"
                "opacity 0.80 0.70, float on, match:class ^(blueman-manager)$"
                "opacity 0.80 0.70, float on, match:class ^(.blueman-manager-wrapped)$"
                "opacity 0.80 0.70, float on, match:class ^(nm-applet)$"
                "opacity 0.80 0.70, float on, match:class ^(nm-connection-editor)$"
                "opacity 0.80 0.70, float on, match:class ^(org.kde.polkit-kde-authentication-agent-1)$"
                "float on, pin on, match:title ^(Picture-in-Picture)$, match:class ^(zen|zen-beta|floorp|firefox)$"
                "content game, sync_fullscreen on, fullscreen on, border_size 1, no_shadow on, no_blur on, no_anim on, match:tag games"
                "tag +games, match:content game"
                "tag +games, match:class ^(steam_app.*|steam_app_d+)$"
                "tag +games, match:class ^(gamescope)$"
                "tag +games, match:class (Waydroid)"
                "tag +games, match:class (osu!)"
                "float on, match:class ^(qt5ct)$"
                "float on, match:class ^(eog)$"
              ];
              binde = [
                # Resize windows
                "$mainMod SHIFT, right, resizeactive, 100 0"
                "$mainMod SHIFT, left, resizeactive, -100 0"
                "$mainMod SHIFT, up, resizeactive, 0 -100"
                "$mainMod SHIFT, down, resizeactive, 0 100"

                # Functional keybinds
                ",XF86MonBrightnessDown,exec,brightnessctl set 2%-"
                ",XF86MonBrightnessUp,exec,brightnessctl set +2%"
                ",XF86AudioLowerVolume,exec,pamixer -d 2"
                ",XF86AudioRaiseVolume,exec,pamixer -i 2"
              ];
              bind = [
                # Keybinds help menu
                "$mainMod, slash, exec, ${./scripts/keybinds.sh}"

                # Window/Session actions
                "$mainMod, Q, killactive"
                "$mainMod SHIFT, Q, exec, hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill" # Quit active window and all open instances
                "$mainMod, delete, exit" # kill hyperland session
                "$mainMod, W, togglefloating" # toggle the window on focus to float
                "$mainMod SHIFT, G, togglegroup" # toggle the window on focus to float
                "ALT, return, fullscreen" # toggle the window on focus to fullscreen
                "$mainMod ALT, L, exec, hyprlock" # lock screen
                "$mainMod, backspace, exec, pkill -x wlogout || wlogout -b 4" # logout menu

                # Applications/Programs
                "$mainMod, Return, exec, $term"
                "$mainMod, F, exec, $fileManager"
                "$mainMod, C, exec, $editor"
                "$mainMod, B, exec, $browser"
                "$CONTROL ALT, DELETE, exec, $term -e '${getExe pkgs.btop}'" # System Monitor
                "$mainMod CTRL, C, exec, hyprpicker --autocopy --format=hex" # Colour Picker

                "$mainMod, SPACE, exec, noctalia-shell ipc call launcher toggle"
                "$mainMod, G, exec, launcher games" # game launcher
                "$mainMod ALT, G, exec, ${./scripts/gamemode.sh}" # disable hypr effects for gamemode
                "$mainMod, V, exec, ${./scripts/ClipManager.sh}" # Clipboard Manager

                # Screenshot/Screencapture
                "$mainMod SHIFT, R, exec, ${./scripts/screen-record.sh} a" # Screen Record (area select)
                "$mainMod CTRL, R, exec, ${./scripts/screen-record.sh} m" # Screen Record (monitor select)
                "$mainMod, P, exec, ${./scripts/screenshot.sh} s" # drag to snip an area / click on a window to print it
                "$mainMod CTRL, P, exec, ${./scripts/screenshot.sh} sf" # frozen screen, drag to snip an area / click on a window to print it
                "$mainMod, print, exec, ${./scripts/screenshot.sh} m" # print focused monitor
                "$mainMod ALT, P, exec, ${./scripts/screenshot.sh} p" # print all monitor outputs

                # Functional keybinds
                ",xf86Sleep, exec, systemctl suspend" # Put computer into sleep mode
                ",XF86AudioMicMute,exec,pamixer --default-source -t" # mute mic
                ",XF86AudioMute,exec,pamixer -t" # mute audio
                ",XF86AudioPlay,exec,playerctl play-pause" # Play/Pause media
                ",XF86AudioPause,exec,playerctl play-pause" # Play/Pause media
                ",xf86AudioNext,exec,playerctl next" # go to next media
                ",xf86AudioPrev,exec,playerctl previous" # go to previous media

                # to switch between windows in a floating workspace
                "$mainMod, Tab, cyclenext"
                "$mainMod, Tab, bringactivetotop"

                # Switch workspaces relative to the active workspace with mainMod + CTRL + [←→]
                "$mainMod CTRL, right, workspace, r+1"
                "$mainMod CTRL, left, workspace, r-1"

                # move to the first empty workspace instantly with mainMod + CTRL + [↓]
                "$mainMod CTRL, down, workspace, empty"

                # Move focus with mainMod + arrow keys
                "$mainMod, left, movefocus, l"
                "$mainMod, right, movefocus, r"
                "$mainMod, up, movefocus, u"
                "$mainMod, down, movefocus, d"
                #"ALT, Tab, movefocus, d"

                # Scroll through existing workspaces with mainMod + scroll
                "$mainMod, mouse_down, workspace, e+1"
                "$mainMod, mouse_up, workspace, e-1"

                # Move active window around current workspace with mainMod + ALT [←→↑↓]
                "$mainMod ALT, left, movewindow, l"
                "$mainMod ALT, right, movewindow, r"
                "$mainMod ALT, up, movewindow, u"
                "$mainMod ALT, down, movewindow, d"

                # Swap active window around current workspace with mainMod + CTRL + ALT [←→↑↓]
                "$mainMod CTRL ALT, left, swapwindow, l"
                "$mainMod CTRL ALT, right, swapwindow, r"
                "$mainMod CTRL ALT, up, swapwindow, u"
                "$mainMod CTRL ALT, down, swapwindow, d"

                # Special workspaces (scratchpad)
                "$mainMod CTRL, Z, movetoworkspacesilent, special"
                "$mainMod SHIFT, Z, movetoworkspace, special"
                "$mainMod, Z, togglespecialworkspace,"
              ]
              ++ (builtins.concatLists (
                builtins.genList (
                  x:
                  let
                    ws =
                      let
                        c = (x + 1) / 10;
                      in
                      builtins.toString (x + 1 - (c * 10));
                  in
                  [
                    "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
                    "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                    "$mainMod CTRL, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
                  ]
                ) 10
              ));
              bindm = [
                # Move/Resize windows with mainMod + LMB/RMB and dragging
                "$mainMod, mouse:272, movewindow"
                "$mainMod, mouse:273, resizewindow"
              ];

              binds = {
                workspace_back_and_forth = 0;
                #allow_workspace_cycles=1
                #pass_mouse_when_bound=0
              };

              monitor = [
                # Easily plug in any monitor
                ",preferred,auto,1"
              ];

              workspace = ["1,default:true"];
            };
          };
        }
      )
    ];
}
