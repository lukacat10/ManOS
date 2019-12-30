if shell.getRunningProgram() ~= "startup" then
    if fs.exists("startup") then
        fs.delete("startup")
    elseif fs.exists("startup.lua") then
        fs.delete("startup.lua")
    end
    fs.copy(shell.getRunningProgram(), startup)
    os.reboot()
end
if fs.exists("manos.lua") then
    fs.delete("manos.lua")
end
if fs.exists("manos_dir") then
    fs.delete("manos_dir")
end
if fs.exists("open") then
    fs.delete("open")
end
if fs.exists("close") then
    fs.delete("close")
end
if fs.exists("startsharing") then
    fs.delete("startsharing")
end
if fs.exists("stopsharing") then
    fs.delete("stopsharing")
end
shell.run("wget https://raw.githubusercontent.com/lukacat10/ManOS/master/manos.lua")
shell.run("wget https://raw.githubusercontent.com/lukacat10/ManOS/master/manos_dir/quarry_manager.lua")
shell.run("wget https://raw.githubusercontent.com/lukacat10/ManOS/master/manos_dir/sharing_manager.lua")
shell.run("wget https://raw.githubusercontent.com/lukacat10/ManOS/master/manos_dir/sheets.lua")
shell.run("pastebin get https://pastebin.com/iwc51FGa open")
shell.run("pastebin get https://pastebin.com/DNFCQ38i close")
shell.run("pastebin get https://pastebin.com/qt4v7tKt startsharing")
shell.run("pastebin get https://pastebin.com/BvdBz8bP stopsharing")
shell.run("mkdir manos_dir")
shell.run("mv quarry_manager.lua manos_dir/quarry_manager.lua")
shell.run("mv sharing_manager.lua manos_dir/sharing_manager.lua")
shell.run("mv sheets.lua manos_dir/sheets.lua")
if fs.exists("startup") then
    fs.delete("startup")
elseif fs.exists("startup.lua") then
    fs.delete("startup.lua")
end
fs.move("manos.lua", "startup")