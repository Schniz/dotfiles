return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    tabline = {
      lualine_a = {
        { 'buffers', }
      }
    },
  },
  init = function()
    vim.o.cmdheight = 0
  end
}
