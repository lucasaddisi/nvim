vim.keymap.set("n", "<leader>=", function()
    local start_line = 1
    local end_line = vim.api.nvim_buf_line_count(0)

    -- Construct the command
    local cmd = "terraform fmt -"

    -- Execute the command
    vim.cmd(start_line .. "," .. end_line .. "!" .. cmd)
end, { buffer = true, desc = "Format Terraform file" })
