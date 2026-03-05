return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    {
      "2kabhishek/nerdy.nvim",
      dependencies = {
        "folke/snacks.nvim",
      },
    },
  },
  cmd = { "Telescope", "Files", "History", "GFiles", "Buffers", "Rg" },
  keys = {
    { "<C-p>", "<cmd>Files<CR>", desc = "Find files" },
    { "<leader><tab>", "<cmd>Buffers<CR>", desc = "List buffers" },
    { "<tab>", "<cmd>Buffers<CR>", desc = "List buffers", silent = true },
    { "<localleader>P", "<cmd>GFiles<CR>", desc = "Git files" },
    {
      "<leader>ss",
      function()
        local telescope = require("telescope.builtin")
        local current_word = ""
        local node = vim.treesitter.get_node()
        if node then
          current_word = vim.treesitter.get_node_text(node, vim.api.nvim_get_current_buf(), nil)
          telescope.grep_string({ search = current_word, word_match = "-w" })
        end
      end,
      desc = "Search word under cursor",
    },
    {
      "<leader>L",
      function()
        require("telescope.builtin").diagnostics({ layout_strategy = "vertical" })
      end,
      desc = "List diagnostics",
    },
    {
      "<leader>od",
      function()
        local telescope = require("telescope.builtin")
        local previewers = require("telescope.previewers")

        local delta = previewers.new_termopen_previewer({
          get_command = function(entry)
            return { "diff-for-file", entry.value }
          end,
        })

        telescope.find_files({ find_command = { "dfile-list" }, previewer = delta })
      end,
      desc = "Open diff files",
    },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        layout_strategy = "flex",
        layout_config = {
          flex = {
            flip_columns = 150,
          },
        },
        set_env = {
          LESS = "",
          DELTA_PAGER = "bat",
        },
        path_display = {
          filename_first = {
            reverse_directories = false,
          },
        },
        mappings = {
          i = {
            -- emacs style: go to the beginning of the line
            ["<c-a>"] = function()
              vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes("<home>", true, false, true),
                "n",
                true
              )
            end,
            ["<c-e>"] = function()
              vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes("<end>", true, false, true),
                "n",
                true
              )
            end,
            ["<esc>"] = actions.close,
            ["<cr>"] = function(prompt_bufnr)
              local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
              local multi = picker:get_multi_selection()
              if not vim.tbl_isempty(multi) then
                require("telescope.actions").close(prompt_bufnr)
                for _, j in pairs(multi) do
                  if j.path ~= nil then
                    vim.cmd(string.format("%s %s", "edit", j.path))
                  end
                end
              else
                require("telescope.actions").select_default(prompt_bufnr)
              end
            end,
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_cursor({}),
        },
      },
    })

    telescope.load_extension("ui-select")
    telescope.load_extension("nerdy")

    -- Register commands after telescope is loaded
    local builtin = require("telescope.builtin")
    vim.api.nvim_create_user_command("Files", function()
      builtin.find_files({ find_command = { "rg", "--files", "--hidden", "--glob=!.git/" } })
    end, {})
    vim.api.nvim_create_user_command("History", builtin.oldfiles, {})
    vim.api.nvim_create_user_command("GFiles", builtin.git_files, {})
    vim.api.nvim_create_user_command("Buffers", builtin.buffers, {})
    vim.api.nvim_create_user_command("Rg", function(args)
      if args.args == "" then
        builtin.live_grep()
      else
        builtin.grep_string({ search = args.args })
      end
    end, { nargs = "?" })
  end,
}
