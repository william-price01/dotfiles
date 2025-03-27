return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  init = function()
    vim.cmd.colorscheme 'catppuccin'
  end,
  opts = {
    transparent_background = false,
    styles = {
      comments = {}, -- by default it's italic
      conditionals = {}, -- by default it's italic
    },
    integrations = {
      dap = true,
      dap_ui = true,
      flash = true,
      mason = true,
      blink_cmp = true,
      mini = {
        enabled = true,
      },
      color_overrides = {
        mocha = {
          base = '#000000',
          mantle = '#000000',
          crust = '#000000',
        },
      },
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { 'italic' },
          hints = { 'italic' },
          warnings = { 'italic' },
          information = { 'italic' },
        },
        underlines = {
          errors = { 'undercurl' },
          hints = { 'undercurl' },
          warnings = { 'undercurl' },
          information = { 'undercurl' },
        },
        inlay_hints = {
          background = true,
        },
      },
      neotest = true,
      semantic_tokens = true,
      treesitter = true,
      which_key = true,
      telescope = {
        enabled = true,
      },
    },
  },
}
