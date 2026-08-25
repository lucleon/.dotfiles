return {
  cmd = { 'clangd', '--background-index', '--clang-tidy' },
  filetypes = { 'c', 'cpp'},
  root_markers = { '.clangd', 'compile_commands.json', '.git' },
}
