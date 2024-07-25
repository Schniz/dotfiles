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
        path_display = {
          filename_first = {
            reverse_directories = false
          }
        },
        mappings = {
          i = {
            -- emacs style: go to the beginning of the line
            ["<c-a>"] = function()
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<home>", true, false, true), "n", true)
            end,
            ["<c-e>"] = function()
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<end>", true, false, true), "n", true)
            end,
            ["<esc>"] = actions.close,
            ["<cr>"] = function(prompt_bufnr)
              local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
              local multi = picker:get_multi_selection()
              if not vim.tbl_isempty(multi) then
                require('telescope.actions').close(prompt_bufnr)
                for _, j in pairs(multi) do
                  if j.path ~= nil then
                    vim.cmd(string.format('%s %s', 'edit', j.path))
                  end
                end
              else
                require('telescope.actions').select_default(prompt_bufnr)
              end
            end
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
    vim.api.nvim_create_user_command("History", telescope.oldfiles, opts)
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
      local node = vim.treesitter.get_node()
      if node then
        current_word = vim.treesitter.get_node_text(node, vim.api.nvim_get_current_buf(), nil)
        telescope.grep_string({ search = current_word, word_match = "-w" })
      end
    end)

    vim.keymap.set("n", "<leader>L", function()
      telescope.diagnostics({ layout_strategy = "vertical" })
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
