return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim' },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup {
      defaults = {
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
    vim.keymap.set("n", "<localleader>P", ":GFiles<CR>")
    vim.keymap.set("n", "<leader>ss", function()
      local current_word = ""

      current_word = vim.treesitter.get_node_text(vim.treesitter.get_node(), vim.api.nvim_get_current_buf(), nil)

      -- if current_word == "" then
      --   current_word = vim.api.nvim_eval("expand(\"<cword>\")")
      -- end

      telescope.grep_string({ search = current_word, word_match = "-w" })
    end)

    -- noremap <leader>of :Files %:h<CR>
    -- noremap <silent> <leader>od :call fzf#run(fzf#wrap({'source': 'dfile-list', 'options': '-m --preview "diff-for-file {}"'}))<CR>

    vim.keymap.set("n", "<leader>od", function()
      telescope.find_files({ find_command = { "dfile-list" } })
    end)
  end
}
