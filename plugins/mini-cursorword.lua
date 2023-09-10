return {
  {
    "echasnovski/mini.cursorword",
    enabled = true,
    version = '*',
    name = "mini.cursorword",
    event = "BufRead",
    config = function()
      require('mini.cursorword').setup()
    end,
  },
}
