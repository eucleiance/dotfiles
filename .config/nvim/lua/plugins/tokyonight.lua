return {
  {
    "folke/tokyonight.nvim",
    opts = {
--      transparent = false,
--      styles = {
--        sidebars = "transparent",
--        floats = "transparent",
--      },
      style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      light_style = "day", -- The theme is used when the background is set to light
      transparent = false, -- Enable this to disable setting the background color
      terminal_colors = false, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = false },
        keywords = { italic = false },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent", -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
      },
      sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
      dim_inactive = false, -- dims inactive windows
      lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

      --- You can override specific color groups to use other groups or a hex color
      --- function will be called with a ColorScheme table
      ---@param colors ColorScheme
      on_colors = function(colors)
      colors.bg = "#1c1c1c"
      colors.bg_dark = "#1c1c1c"
      -- colors.bg_float = "#1c1c1c"
      -- colors.bg_highlight = "#1c1c1c"   -- Nope
      colors.bg_sidebar = "#1c1c1c"
      colors.bg_statusline = "#1c1c1c"  -- Lualine
      -- colors.bg_visual = "#1c1c1c"
      -- colors.black = "#1c1c1c"
      -- colors.dark3 = "#545c7e"
      -- colors.dark5 = "#737aa2"
      colors.comment = "#6873a6"  -- comments
      end,

      --- You can override specific highlights to use other groups or a hex color
      --- function will be called with a Highlights and ColorScheme table
      ---@param highlights Highlights
      ---@param colors ColorScheme
      on_highlights = function(hl, c) end,
    },
  },
}
