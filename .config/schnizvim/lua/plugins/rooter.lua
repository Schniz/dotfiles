-- This ensures we automatically `cd` to the nearest project

return {
  'airblade/vim-rooter',
  init = function()
    vim.g.rooter_patterns = {
      'package.json',
      'Rakefile',
      'Makefile',
      'Podfile',
      'shard.yml',
      'requirements.txt',
      'Gemfile',
      'mix.exs',
      'Cargo.toml',
      'go.mod',
      '.git/',
      'lazy-lock.json',
    }
  end
}
