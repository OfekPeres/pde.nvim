return {
  {
    dir = "/Users/ofek/my-neovim-plugins/open-brazil-tests.nvim",
    dev = true,
    -- lazy = true,
    config = function()
      require("open-brazil-tests").setup({ debug = true })
    end,
    keys = {
      {
        "<leader>ut",
        function()
          require("open-brazil-tests").open_telescope_picker()
        end,
        desc = "Open Brazil Unit Tests in default browser",
        mode = "n", -- normal mode
      },
    },
  },
}
