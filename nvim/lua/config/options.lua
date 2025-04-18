vim.opt.completeopt = {'menu', 'menuone' , 'noselect'}
vim.opt.hidden = true
vim.opt.expandtab = true
vim.opt.ignorecase = true               -- Ignore case
vim.opt.joinspaces = false              -- No double spaces with join
vim.opt.list = true                     -- Show some invisible characters
vim.opt.number = true                   -- Show line numbers
vim.opt.relativenumber = true           -- Relative line numbers
vim.opt.scrolloff = 4                   -- Lines of context
vim.opt.shiftround = true               -- Round indent
vim.opt.shiftwidth = 2                  -- Size of an indent
vim.opt.sidescrolloff = 8               -- Columns of context
vim.opt.smartcase = true                -- Do not ignore case with capitals
vim.opt.smartindent = true              -- Insert indents automatically
vim.opt.splitbelow = true               -- Put new windows below current
vim.opt.splitright = true               -- Put new windows right of current
vim.opt.tabstop = 2                     -- Number of spaces tabs count for
vim.opt.termguicolors = true            -- True color support
vim.opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
vim.opt.wrap = false                    -- Disable line wrap
vim.opt.conceallevel=2
vim.opt.listchars = {
  trail = '-'
}
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})
