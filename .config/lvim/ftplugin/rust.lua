local status_ok, dap_install = pcall(require, "dap-install")
if not status_ok then
  vim.notify("Could not import dap-install")
  return
end
dap_install.config("codelldb", {})
