return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        url = "ofek@git.amazon.com:pkg/NinjaHooks",
        branch = "mainline",
        lazy = false,
        config = function(plugin)
          vim.opt.rtp:prepend(plugin.dir .. "/configuration/vim/amazon/brazil-config")
          vim.filetype.add({
            filename = {
              ["Config"] = function()
                vim.b.brazil_package_Config = 1
                return "brazil-config"
              end,
            },
          })
        end,
      },
    },

    opts = function(_, opts)
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")
      configs.barium = {
        default_config = {
          cmd = { "barium" },
          filetypes = { "brazil-config" },
          root_dir = function(fname)
            return lspconfig.util.find_git_ancestor(fname)
          end,
          settings = {},
        },
      }
      lspconfig.barium.setup({})
      return opts
    end,
  },
}
