return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close
          },
        },
      }
    }
  end,
  dependencies = { 'nvim-lua/plenary.nvim' },
  init = function()
    local telescope = require("telescope.builtin")
    local opts = {}

    vim.api.nvim_create_user_command("Files", telescope.find_files, opts)
    vim.api.nvim_create_user_command("GFiles", telescope.git_files, opts)
    vim.api.nvim_create_user_command("Buffers", telescope.buffers, opts)
    vim.api.nvim_create_user_command("Rg", function(args)
      if args.args == "" then
        telescope.live_grep()
      else
        telescope.grep_string({ search = args.args })
      end
    end, {
      nargs = "?"
    })

    vim.keymap.set("n", "<C-p>", ":Files<CR>")
    vim.keymap.set("n", "<leader><tab>", ":Buffers<CR>")
    vim.keymap.set("n", "<localleader>P", ":GFiles<CR>")
    vim.keymap.set("n", "<leader>ss", function()
      local current_word = ""

      current_word = vim.treesitter.get_node_text(vim.treesitter.get_node(), vim.api.nvim_get_current_buf(), nil)

      -- if current_word == "" then
      --   current_word = vim.api.nvim_eval("expand(\"<cword>\")")
      -- end

      telescope.grep_string({ search = current_word })
    end)
  end
}
