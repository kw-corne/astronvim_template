-- If the enter key does something else, it will give errors in the quickfix list
-- So rebind it to default enter behaviour
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(args) vim.api.nvim_buf_set_keymap(args.buf, "n", "<Enter>", "<Enter>", {}) end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "no-neck-pain",
  callback = function() vim.api.nvim_command 'set winbar=""' end,
})

local prompt_term_cmd_key = "<leader>tc"
local prompt_term_direction_key = "<leader>td"
local exec_curr_cmd_key = "<F6>"

local curr_cmd = nil
local curr_direction = "float"

local function prompt_term_cmd() curr_cmd = vim.fn.input "Cmd: " end

local direction_short = {
  h = "horizontal",
  f = "float",
  v = "vertical",
}

local function prompt_term_direction()
  curr_direction = vim.fn.input "Direction: "

  if direction_short[curr_direction] then curr_direction = direction_short[curr_direction] end
end

local function exec_curr_cmd()
  if curr_cmd == nil then
    print("Set a command first using " .. prompt_term_cmd_key)
    return
  end

  local cmd_to_exec = 'TermExec cmd="' .. curr_cmd .. '" direction=' .. curr_direction
  vim.api.nvim_command "wa"
  vim.api.nvim_command(cmd_to_exec)
end

vim.keymap.set("n", prompt_term_cmd_key, prompt_term_cmd)
vim.keymap.set("n", prompt_term_direction_key, prompt_term_direction)
vim.keymap.set("n", exec_curr_cmd_key, exec_curr_cmd)

if vim.g.neovide then
  vim.o.guifont = "JetBrainsMonoNL NFM"
  vim.g.neovide_scale_factor = 0.95
end

if vim.fn.has "win32" == 1 then
  vim.o.shell = "powershell"
  vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
  vim.o.shellquote = '"'
  vim.o.shellxquote = ""
  vim.o.shellpipe = "| Out-File -Encoding UTF8"
  vim.o.shellredir = "| Out-File -Encoding UTF8"
  vim.o.shellxescape = ""
  vim.o.shellxquote = ""
end
