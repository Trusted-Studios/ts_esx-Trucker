-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Trusted Development || FX-Manifest
-- ════════════════════════════════════════════════════════════════════════════════════ --
fx_version 'cerulean'
lua54 'yes'
games { 'gta5' }

author 'Trusted-Development | Simple and old Trucker Job'
description 'Simple and old Trucker Job made by GMW'
repository 'https://trusted.tebex.io'
version '2.1.2'

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
}

client_scripts {
    'config.lua',
    'client/*.lua',
}

server_scripts {
    'config.lua',
    'server/*.lua',
}

dependencies {
	'es_extended',
}
