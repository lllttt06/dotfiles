local wezterm = require 'wezterm'

-- Common settings
local config = {
    color_scheme = "Tokyo Night",
    font_size = 15,
    font = wezterm.font("Hack Nerd Font"),
    front_end = "OpenGL",

    window_background_opacity = 1,
    window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
    window_background_image = '/Users/s18556/dotfiles/jododaira.jpg',
    window_background_image_hsb = {
        -- Darken the background image by reducing it to 1/3rd
        brightness = 0.2,
    
        -- You can adjust the hue by scaling its value.
        -- a multiplier of 1.0 leaves the value unchanged.
        hue = 1.0,
    
        -- You can adjust the saturation also.
        saturation = 1.0,
    },

    use_fancy_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
}

return config
