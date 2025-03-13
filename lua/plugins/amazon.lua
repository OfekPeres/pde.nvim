-- ~/.config/nvim/lua/plugins/amazon.lua
-- From the LazyVim section of: https://w.amazon.com/bin/view/Bemol/#HIntegratingwithLSPclients
return {
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
}
