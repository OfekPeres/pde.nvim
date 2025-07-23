-- ~/.config/nvim/lua/plugins/amazon.lua
-- From the LazyVim section of: https://w.amazon.com/bin/view/Bemol/#HIntegratingwithLSPclients
return {
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    opts = function(_, opts)
      local root_dir = require("jdtls.setup").find_root({ "packageInfo" }, "Config")
      vim.notify("Current dir is: " .. vim.fn.getcwd())
      vim.notify("Root Dir is: " .. root_dir)
      local workspaces = {}
      if root_dir then
        local file = io.open(root_dir .. "/.bemol/ws_root_folders")
        if file then
          for line in file:lines() do
            table.insert(workspaces, "file://" .. line)
          end
          file:close()
        end
      end
      for _, line in ipairs(workspaces) do
        vim.lsp.buf.add_workspace_folder(line)
      end

      local project_name = opts.project_name(root_dir)
      vim.notify("Project name is: " .. project_name)
      vim.notify("JDTLS path is: " .. opts.jdtls_workspace_dir(project_name))
      local cmd = vim.deepcopy(opts.cmd)
      if project_name then
        vim.list_extend(cmd, {
          "-configuration",
          opts.jdtls_config_dir(project_name),
          "-data",
          opts.jdtls_workspace_dir(project_name),
        })
      end

      opts.jdtls = {
        cmd = cmd,
        init_options = {
          workspaceFolders = workspaces,
        },
        root_dir = root_dir,
      }
    end,
    {
      "folke/snacks.nvim",
      ---@type snacks.Config.base
      opts = {
        ---@type snacks.gitbrowse.Config
        ---@diagnostic disable-next-line: missing-fields
        gitbrowse = {
          url_patterns = {
            ["code.amazon.com"] = {
              branch = "trees/{branch}",
              file = "/blobs/{branch}/--/{file}#L{line_start}-L{line_end}",
              permalink = "/blobs/{commit}/--/{file}#L{line_start}-L{line_end}",
              commit = "/commits/{commit}",
            },
          },

          remote_patterns = {
            -- Amazon specific pattern
            { "^ssh://git.amazon.com:2222/pkg/(.+)$", "https://code.amazon.com/packages/%1" },

            -- Original patterns
            { "^(https?://.*)%.git$", "%1" },
            { "^git@(.+):(.+)%.git$", "https://%1/%2" },
            { "^git@(.+):(.+)$", "https://%1/%2" },
            { "^git@(.+)/(.+)$", "https://%1/%2" },
            { "^org%-%d+@(.+):(.+)%.git$", "https://%1/%2" },
            { "^ssh://git@(.*)$", "https://%1" },
            { "^ssh://([^:/]+)(:%d+)/(.*)$", "https://%1/%3" },
            { "^ssh://([^/]+)/(.*)$", "https://%1/%2" },
            { "ssh%.dev%.azure%.com/v3/(.*)/(.*)$", "dev.azure.com/%1/_git/%2" },
            { "^https://%w*@(.*)", "https://%1" },
            { "^git@(.*)", "https://%1" },
            { ":%d+", "" },
            { "%.git$", "" },
          },
        },
      },
    },
  },
}
