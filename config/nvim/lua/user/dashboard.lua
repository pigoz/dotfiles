local M = {}

local function nvim_version()
    local v = vim.version()
    return 'nvim-' .. table.concat({ v.major, v.minor, v.patch }, '.')
end

local function lua_version()
    return _VERSION
end

local function luajit_version()
    return '(' .. jit.version .. ')'
end

local home = os.getenv('HOME')

local custom_header = {
    [[]],
    [[__________________|      |____________________________________________]],
    [[     ,--.    ,--.          ,--.   ,--.                                ]],
    [[    |oo  | _  \\ `.       | oo | |  oo|                               ]],
    [[o  o|~~  |(_) /   ;       | ~~ | |  ~~|o  o  o  o  o  o  o  o  o  o  o]],
    [[    |/\/\|   '._,'        |/\/\| |/\/\|                               ]],
    [[__________________        ____________________________________________]],
    [[                  |      |                                            ]],
    [[]],
}

local custom_center = {
    { icon = '  ',
        desc = 'Recently latest session                  ',
        shortcut = 'SPC s l',
        action = 'SessionLoad' },
    { icon = '  ',
        desc = 'Recently opened files                   ',
        action = 'DashboardFindHistory',
        shortcut = 'SPC f h' },
    { icon = '  ',
        desc = 'Find  File                              ',
        action = 'Telescope find_files find_command=rg,--hidden,--files',
        shortcut = 'SPC f f' },
    { icon = '  ',
        desc = 'File Browser                            ',
        action = 'Telescope file_browser',
        shortcut = 'SPC f b' },
    { icon = '  ',
        desc = 'Find  word                              ',
        action = 'Telescope live_grep',
        shortcut = 'SPC f w' },
    { icon = '  ',
        desc = 'Open Personal dotfiles                  ',
        action = 'Telescope dotfiles path=' .. home .. '/.dotfiles',
        shortcut = 'SPC f d' },
}

local custom_footer = {
    nvim_version(),
    table.concat({ lua_version(), luajit_version() }, ' ')
}

M.config = function()
    local db = require('dashboard')
    db.custom_header = custom_header
    db.custom_center = custom_center
    db.custom_footer = custom_footer
end

return M
