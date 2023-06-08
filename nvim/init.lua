local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd
local session_path = vim.fs.normalize(vim.fn.getcwd() .. '/session.vim')

opt.number = true
opt.relativenumber = true

opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.swapfile = false
opt.sessionoptions = "buffers,curdir,folds,tabpages,winsize"

autocmd("VimEnter", {
  pattern = "",
  nested = true,
  once = true,
  callback = function()
    local exists = vim.fn.filereadable(session_path)

    if vim.fn.argc() < 1 and exists > 0 then
      vim.cmd("source " .. session_path)
    end
  end,
})

-- autocmd("VimLeave", {
--   pattern = "",
--   nested = true,
--   once = true,
--   callback = function()
--     vim.cmd("mksession! " .. session_path)
--   end,
-- })
