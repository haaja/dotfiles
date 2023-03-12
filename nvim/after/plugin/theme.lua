local status, _ = pcall(vim.cmd, 'colorscheme nightfly')
if not status then
    print('nightlfy colorscheme not found')
    return
end

