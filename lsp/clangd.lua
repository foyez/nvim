return {
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=iwyu',
  },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  root_markers = {
    'compile_commands.json',
    'compile_flags.txt',
    '.clangd',
    '.git',
    'Makefile',
    'CMakeLists.txt',
  },
  capabilities = {
    offsetEncoding = { 'utf-16' },
  },
}