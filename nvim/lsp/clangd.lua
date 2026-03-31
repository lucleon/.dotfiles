return {
  cmd = { 'clangd', '--background-index', '--clang-tidy' },
  filetypes = { 'c', 'cpp', 'h', 'hpp' },
  root_markers = { '.clangd', 'compile_commands.json', '.git' },
}
