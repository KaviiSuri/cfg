local status_ok, rust_tools = pcall(require, "rust-tools")
if not status_ok then
    return
end

rust_tools.setup {
    tools = {
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },
}
