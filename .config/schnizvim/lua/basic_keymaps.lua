vim.keymap.set({ "n", "v" }, "<backspace>", "<C-^>", { desc = "Switch to alternate buffer" })
vim.keymap.set({ "n", "v" }, "#", "^", { desc = "Jump to first non-blank character" })
vim.keymap.set({ "n", "v" }, ";", ":", { desc = "Enter command mode" })
vim.keymap.set({ "n", "v" }, "j", "gj", { silent = true, desc = "Move down (display lines)" })
vim.keymap.set({ "n", "v" }, "k", "gk", { silent = true, desc = "Move up (display lines)" })
vim.keymap.set("n", "<leader>q", ":noh<CR>", { silent = true, desc = "Clear search highlight" })
vim.keymap.set("n", "<CR>", ":noh<CR>", { silent = true, desc = "Clear search highlight" })
vim.keymap.set(
  "n",
  "<C-c>",
  ":noh<CR><Esc>",
  { silent = true, desc = "Clear search highlight and escape" }
)
vim.keymap.set("i", "<C-c>", "<ESC>", { silent = true, desc = "Exit insert mode" })
vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })
vim.keymap.set(
  "n",
  "<leader>or",
  ":e <C-R>=expand('%:p:h') . '/'<CR>",
  { desc = "Open file relative to current" }
)
vim.keymap.set(
  "n",
  "<leader>o<C-r>",
  ":call fzf#vim#files(getcwd(), { 'options': ['--query', expand('%:h'), '--preview', 'bat {} --color always'] })<CR>",
  { desc = "FZF files from current dir" }
)
vim.keymap.set("n", "<leader>f", "za", { desc = "Toggle fold" })

-- windows

vim.keymap.set("n", "<leader>e", ":bn<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<leader>w", ":bp<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<leader>dd", ":bd<CR>", { silent = true, desc = "Delete buffer" })
vim.keymap.set("n", "<leader>DD", ":bd!<CR>", { silent = true, desc = "Force delete buffer" })
vim.keymap.set(
  { "n", "v" },
  "<leader>bo",
  ":%bd|e#",
  { silent = true, desc = "Close all buffers except current" }
)

vim.keymap.set("n", "<leader>di", function()
  vim.diagnostic.open_float(nil)
end, { silent = true, desc = "Show diagnostics float" })

-- evil mode muahahaha
vim.keymap.set("c", "<C-a>", "<Home>", { desc = "Go to start of line" })
vim.keymap.set("c", "<C-e>", "<End>", { desc = "Go to end of line" })

local function yank_range(opts)
  opts = opts or {}
  local l1, l2 = vim.fn.line("v"), vim.fn.line(".")
  local path = ""
  if opts.from_git_root then
    local absolute_path = vim.fn.expand("%:p")
    local git_root = vim.fn.systemlist({
      "git",
      "-C",
      vim.fn.fnamemodify(absolute_path, ":h"),
      "rev-parse",
      "--show-toplevel",
    })[1]
    path = vim.v.shell_error == 0 and vim.fs.relpath(git_root, absolute_path)
      or vim.fn.expand("%:~:.")
  else
    path = vim.fn.expand("%:~:.")
  end
  local lines = tostring(l1)
  if l1 ~= l2 then
    lines = ("%d-%d"):format(math.min(l1, l2), math.max(l1, l2))
  end
  local result = ("%s:%s"):format(path, lines)
  vim.fn.setreg("+", result)
  vim.notify(
    ("Yanked `%s`"):format(result),
    "info",
    { title = "yanked", id = "yank", ft = "markdown" }
  )
end

vim.keymap.set("v", "<leader>yr", function()
  yank_range()
end, {
  silent = true,
  desc = "Yank relative path + selected line range",
})

vim.keymap.set("v", "<leader>yR", function()
  yank_range({ from_git_root = true })
end, {
  silent = true,
  desc = "Yank Git-root-relative path + selected line range",
})
