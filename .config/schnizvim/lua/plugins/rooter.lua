-- This ensures we automatically `cd` to the nearest project

return {
  "airblade/vim-rooter",
  dependencies = { "folke/snacks.nvim" },
  -- enabled = false,
  init = function()
    vim.g.rooter_silent_chdir = 1
    vim.g.rooter_patterns = {
      "package.json",
      "Rakefile",
      "Makefile",
      "Podfile",
      "shard.yml",
      "requirements.txt",
      "Gemfile",
      "mix.exs",
      "Cargo.toml",
      "*.xcworkspace",
      "*.xcproject",
      "go.mod",
      ".terraform/",
      ".git/",
      "lazy-lock.json",
    }

    vim.api.nvim_create_autocmd("DirChanged", {
      callback = function()
        local git = require("snacks.git")
        local git_root = git.get_root()

        if not git_root then
          return
        end

        local dirname = vim.fn.getcwd()
        -- Escape special pattern characters in git_root for gsub
        local escaped_root = git_root:gsub("([%.%-%+%[%]%(%)%$%^%%%?%*])", "%%%1")
        local new_dirname = dirname:gsub(escaped_root, "")

        if new_dirname == "" then
          new_dirname = "/"
        end

        vim.notify(new_dirname, "info", { title = "Directory changed", id = "rooter.changed" })
      end,
    })
  end,
}
