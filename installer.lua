shell.run("wget https://raw.githubusercontent.com/lukacat10/ManOS/master/manos.lua")
shell.run("https://raw.githubusercontent.com/lukacat10/ManOS/master/manos_dir/quarry_manager.lua")
shell.run("https://raw.githubusercontent.com/lukacat10/ManOS/master/manos_dir/sharing_manager.lua")
shell.run("https://raw.githubusercontent.com/lukacat10/ManOS/master/manos_dir/sheets.lua")
shell.run("mkdir manos_dir")
shell.run("mv quarry_manager.lua manos_dir/quarry_manager.lua")
shell.run("mv sharing_manager.lua manos_dir/sharing_manager.lua")
shell.run("mv sheets.lua manos_dir/sheets.lua")