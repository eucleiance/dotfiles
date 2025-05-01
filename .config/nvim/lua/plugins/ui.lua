-- -- Homepage
-- return {
--   "nvimdev/dashboard-nvim",
--   event = "VimEnter",
--   opts = function(_, opts)
--     local logo = [[
-- ███╗   ███╗ █████╗ ██████╗ ██╗  ██╗    ██╗
-- ████╗ ████║██╔══██╗██╔══██╗██║ ██╔╝    ██║
-- ██╔████╔██║███████║██████╔╝█████╔╝     ██║
-- ██║╚██╔╝██║██╔══██║██╔══██╗██╔═██╗     ██║
-- ██║ ╚═╝ ██║██║  ██║██║  ██║██║  ██╗    ██║
-- ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝    ╚═╝
--       ]]
--     logo = string.rep("\n", 8) .. logo .. "\n\n"
--     opts.config.header = vim.split(logo, "\n")
--   end,
-- }


-- Fixing Errors on above code

return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  opts = function(_, opts)
    local logo = [[
███╗   ███╗ █████╗ ██████╗ ██╗  ██╗    ██╗
████╗ ████║██╔══██╗██╔══██╗██║ ██╔╝    ██║
██╔████╔██║███████║██████╔╝█████╔╝     ██║
██║╚██╔╝██║██╔══██║██╔══██╗██╔═██╗     ██║
██║ ╚═╝ ██║██║  ██║██║  ██║██║  ██╗    ██║
╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝    ╚═╝
      ]]
    logo = string.rep("\n", 8) .. logo .. "\n\n"

    -- Ensure opts.config is initialized as a table
    opts.config = opts.config or {}

    -- Assign the header
    opts.config.header = vim.split(logo, "\n")
  end,
}
