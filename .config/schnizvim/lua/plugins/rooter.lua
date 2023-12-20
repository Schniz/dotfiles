-- This ensures we automatically `cd` to the nearest project

return {
  'ahmedkhalf/project.nvim',
  config = function()
    require("project_nvim").setup {
      patterns = {
        'package.json',
        'Rakefile',
        'Makefile',
        'shard.yml',
        'requirements.txt',
        'Gemfile',
        'mix.exs',
        'Cargo.toml',
        'go.mod',
        '.git/'
      }
    }
  end
}
