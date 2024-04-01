return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim' },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup {
      defaults = {
        set_env = {
          LESS = '',
          DELTA_PAGER = 'bat',
        },
        path_display = { "smart" },
        mappings = {
          i = {
            -- emacs style: go to the beginning of the line
            ["<c-a>"] = function()
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<home>", true, false, true), "n", true)
            end,
            ["<c-e>"] = function()
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<end>", true, false, true), "n", true)
            end,
            ["<esc>"] = actions.close
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_cursor {}
        }
      }
    }

    telescope.load_extension("ui-select")
  end,
  init = function()
    local telescope = require("telescope.builtin")
    local opts = {}

    vim.api.nvim_create_user_command("Files", function()
      telescope.find_files({ find_command = { "rg", "--files", "--hidden", "--glob=!.git/" } })
    end, opts)
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
    vim.keymap.set("n", "<tab>", ":Buffers<CR>", { silent = true })
    vim.keymap.set("n", "<localleader>P", ":GFiles<CR>")
    vim.keymap.set("n", "<leader>ss", function()
      local current_word = ""
      current_word = vim.treesitter.get_node_text(vim.treesitter.get_node(), vim.api.nvim_get_current_buf(), nil)
      telescope.grep_string({ search = current_word, word_match = "-w" })
    end)

    vim.keymap.set("n", "<leader>od", function()
      local previewers = require('telescope.previewers')
      local themes = require('telescope.themes')

      local delta = previewers.new_termopen_previewer({
        get_command = function(entry)
          return { 'diff-for-file', entry.value }
        end
      })


      telescope.find_files({ find_command = { "dfile-list" }, previewer = delta })
    end)
  end
}
