return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader><leader>",
      function()
        require("telescope.builtin").find_files({
          hidden = false,
          file_ignore_patterns = { "build/.*" },
        })
        vim.notify("Hello there. cwd is: " .. vim.fn.getcwd())
      end,
      desc = "Find all src/config files in a project",
    },
  },
}
