fx_version   'cerulean'
use_fxv2_oal 'yes'
lua54        'yes'
game         'gta5'

client_scripts {
	'@es_extended/locale.lua',
	"client.lua"
}

server_scripts {
'@oxmysql/lib/MySQL.lua',
	"server.lua"
}

shared_scripts {
	'@pe-lualib/init.lua',
	'@ox_lib/init.lua'
}

dependencies {
	'es_extended',
  'ox_inventory',
	 '/onesync',
	'ox_lib'
}


shared_script '@es_extended/imports.lua'