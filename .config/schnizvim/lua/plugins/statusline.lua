return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'arkav/lualine-lsp-progress' },
  opts = {
    tabline = {
      lualine_a = {
        { 'buffers' }
      }
    },
    sections = {
      lualine_c = {
        'lsp_progress'
      }
    }
  },
  init = function()
    vim.o.cmdheight = 0
  end
}
