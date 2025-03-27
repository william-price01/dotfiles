return {
  -- File explorer as buffer
  'stevearc/oil.nvim',
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = false,
    },
  },
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  lazy = false,
}
