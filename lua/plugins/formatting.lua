return {
  {
    "stevearc/conform.nvim",
    ---@type conform.setupOpts
    opts = {

      formatters_by_ft = {
        smithy = { "trim_whitespace", lsp_format = "last" },
      },
    },
  },
}
