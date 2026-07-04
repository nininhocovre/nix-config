hl.config({
    general = {
        border_size = 2,
        col = {
            active_border = { colors = { "rgba(ca9ee6ff)", "rgba(f2d5cfff)" }, angle = 45 },
            inactive_border = { colors = { "rgba(b4befecc)", "rgba(6c7086cc)" }, angle = 45 },
        },
        gaps_in = 4,
        gaps_out = 8,
        layout = "master",
        resize_on_border = true,
    },
    decoration = {
        blur = {
            enabled = true,
            ignore_opacity = true,
            new_optimizations = true,
            passes = 2,
            size = 6,
            special = true,
            xray = false,
        },
        shadow = {
            enabled = false,
        },
        dim_special = 0.300000,
        rounding = 10,
    },
    dwindle = {
        preserve_split = true,
    },
    master = {
        mfact = 0.60,
        new_on_top = false,
        new_status = "slave",
    },
    ecosystem = {
        no_donation_nag = true,
    },
    group = {
        col = {
            border_active = { colors = { "rgba(ca9ee6ff)", "rgba(f2d5cfff)" }, angle = 45 },
            border_inactive = { colors = { "rgba(b4befecc)", "rgba(6c7086cc)" }, angle = 45 },
            border_locked_active = { colors = { "rgba(ca9ee6ff)", "rgba(f2d5cfff)" }, angle = 45 },
            border_locked_inactive = { colors = { "rgba(b4befecc)", "rgba(6c7086cc)" }, angle = 45 },
        },
    },
    input = {
        tablet = {
            output = "current",
        },
        touchpad = {
            natural_scroll = false,
        },
        follow_mouse = 1,
        force_no_accel = true,
        kb_layout = "us,",
        kb_variant = "intl,",
        numlock_by_default = true,
        repeat_delay = 275,
        repeat_rate = 35,
        sensitivity = 0,
    },
    misc = {
        disable_hyprland_logo = true,
        enable_swallow = true,
        mouse_move_focuses_monitor = true,
        swallow_regex = "^(Alacritty|kitty)$",
        vrr = 2,
    },
    render = {
        direct_scanout = 0,
    },
    xwayland = {
        force_zero_scaling = false,
    },
})
