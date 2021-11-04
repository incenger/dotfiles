-- Change colorscheme
local components = require('feline.presets').default

-- Remove the file info from left component
table.remove(components.active[1], 3)

-- Add empty middle component
table.insert(components.active, 2, {})

components.active[1][2] = {
    provider = 'vi_mode',
    hl = function()
        return {
            name = require('feline.providers.vi_mode').get_mode_highlight_name(),
            fg = require('feline.providers.vi_mode').get_mode_color(),
            style = 'bold'
        }
    end,
    right_sep = ' ',
    -- Uncomment the next line to disable icons for this component and use the mode name instead
    icon = ''
}


components.active[1][3] = {
    provider = 'file_size',
    right_sep = {
        ' ',
    }
}

-- Diasable position on left side
components.active[1][4] = {}

components.active[2][1] = {
    provider = {
        name = 'file_info',
        opts = {
            type = 'short-path',
            file_modified_icon = ""
        },
    }, 
    short_provider = {
        name = 'file_info',
        opts = {
            type = 'base-only',
            file_modified_icon = ""
        },
    },
    hl = {
        style = 'bold'
    },
}

-- Need empty component to make hightlight correct
components.inactive[1] = {{}}
components.inactive[2] = {
    {
        provider = {
            name = 'file_info',
            opts = {
                file_modified_icon = ""
            },
        },
    },
}
components.inactive[3] = {{}}

require('feline').setup('defaults')
