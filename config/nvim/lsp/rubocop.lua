return {
  cmd = { vim.fn.expand("~/.rbenv/shims/rubocop"), '--lsp' },
  filetypes = { 'ruby' },
  root_markers = { "Gemfile", ".git" },
}
