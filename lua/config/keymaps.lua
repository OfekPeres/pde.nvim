-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- These keyamps allow me to swap up/down lines in visual mode using J/K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- This keymap allows me to paste in visual mode and not override my current buffers
vim.keymap.set("v", "<leader>p", '"_dP')

-- This keymap allows me to yank the current file into my clipboard
local setFilePathToClipBoard = function()
  local filepath = vim.fn.expand("%:p")
  vim.fn.setreg("+", filepath)
end

vim.keymap.set("n", "yp", setFilePathToClipBoard, { desc = "Yank the current file path into the clipboard" })

-- require("which-key").add({
--   "yp",
--   setFilePathToClipBoard,
--   desc = "Yank the current file path into the clipboard",
--   mode = "n",
--   group = "+Yank",
-- })

-- You can also create a custom finder
vim.keymap.set("n", "<leader><leader>", function()
  require("telescope.builtin").find_files({
    cwd = vim.fn.getcwd(),
    hidden = false,
  })
  vim.notify("Hello there. cwd is: " .. vim.fn.getcwd())
end, { desc = "Override default lazy map" })
