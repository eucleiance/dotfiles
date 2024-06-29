-- return {
--   'hrsh7th/vim-vsnip',
--   "nvim-cmp",
--   config = {
--     snippet = {
--       expand = function(args)
--         vim.fn["vsnip#anonymous"](args.body)
--       end,
--     },
--   },
-- }


-- When pressing tab it doesn't fallback to the original function but instead it prints the tab character
return {
  "hrsh7th/nvim-cmp",
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")

    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<Tab>"] = cmp.mapping(function(fallback)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true), "n", true)
      end, { "i", "s" }),
    })
  end,
}


-- return {
--   "hrsh7th/nvim-cmp",
--   ---@param opts cmp.ConfigSchema
--   opts = function(_, opts)
--     local has_words_before = function()
--       unpack = unpack or table.unpack
--       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
--     end
--
--     local luasnip = require("luasnip")
--     local cmp = require("cmp")
--
--     opts.mapping = vim.tbl_extend("force", opts.mapping, {
--       ["<Tab>"] = cmp.mapping(function(fallback)
--         if cmp.visible() then
--           -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
--           -- cmp.select_next_item()
--           fallback()
--         -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
--         -- this way you will only jump inside the snippet region
--         elseif luasnip.expand_or_jumpable() then
--           -- luasnip.expand_or_jump()
--           fallback()
--         elseif has_words_before() then
--           -- cmp.complete()
--           fallback()
--         else
--           fallback()
--         end
--       end, { "i", "s" }),
--       ["<S-Tab>"] = cmp.mapping(function(fallback)
--         if cmp.visible() then
--           -- cmp.select_prev_item()
--           fallback()
--         elseif luasnip.jumpable(-1) then
--           -- luasnip.jump(-1)
--           fallback()
--         else
--           fallback()
--         end
--       end, { "i", "s" }),
--     })
--   end,
-- }









-- return {
--   "nvim-cmp",
--   opts = {
--     snippet = {
--       expand = function(args)
--         vim.snippet.expand(args.body)
--       end,
--     },
--   },
--   keys = {
--     {
--       "<Tab>",
--       function()
--         if vim.snippet.jumpable(1) then
--           vim.schedule(function()
--             vim.snippet.jump(1)
--           end)
--           return
--         end
--         return "<Tab>"
--       end,
--       expr = true,
--       silent = true,
--       mode = "i",
--     },
--     {
--       "<Tab>",
--       function()
--         vim.schedule(function()
--           vim.snippet.jump(1)
--         end)
--       end,
--       silent = true,
--       mode = "s",
--     },
--     {
--       "<S-Tab>",
--       function()
--         if vim.snippet.jumpable(-1) then
--           vim.schedule(function()
--             vim.snippet.jump(-1)
--           end)
--           return
--         end
--         return "<S-Tab>"
--       end,
--       expr = true,
--       silent = true,
--       mode = { "i", "s" },
--     },
--   },
-- }
