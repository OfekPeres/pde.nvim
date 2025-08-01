--- Autocomplete - add shift tab behavior
return {
  {

    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },

  -- Tells Lua lsp where to find types for plugins that declare types
  {
    "folke/lazydev.nvim",
    opts = function(_, opts)
      local library_overrides = {
        { path = "lazy.nvim" },
        { path = "LazyVim" },

        -- harpoon cool stuff
        -- { path = "grapple.nvim", words = { "grapple" } },

        { path = "conform.nvim", words = { "conform" } },
        { path = "mason.nvim", words = { "mason" } },
        { path = "nvim-treesitter", words = { "TS", "treesitter" } },
        { path = "snacks.nvim", words = { "snacks" } },
        { path = "telescope.nvim", words = { "telescope" } },
        { path = "tokyonight.nvim", words = { "tokyonight" } },
        { path = "which-key.nvim", words = { "wk", "which-key" } },
      }

      opts.library = vim.list_extend(opts.library or {}, library_overrides)
      return opts
    end,
  },
}
