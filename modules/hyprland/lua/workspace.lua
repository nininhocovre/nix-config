hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "1",
})

hl.workspace_rule({
    workspace = "1",
    default = true,
    persistent = true
})
for i = 2, 5 do
    hl.workspace_rule({
        workspace = i,
        persistent = true
    })
end
