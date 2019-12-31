if shell.getRunningProgram() ~= "startup" then
    if fs.exists("startup") then
        fs.delete("startup")
    elseif fs.exists("startup.lua") then
        fs.delete("startup.lua")
    end
    fs.copy(shell.getRunningProgram(), "startup")
    os.reboot()
end
--Deleting to update the files
if fs.exists("installer.lua") then
    fs.delete("installer.lua")
end
if fs.exists("manos.lua") then
    fs.delete("manos.lua")
end
if fs.exists("manos_dir") then
    fs.delete("manos_dir")
end
if fs.exists("manos_programs/open") then
    fs.delete("manos_programs/open")
end
if fs.exists("manos_programs/close") then
    fs.delete("manos_programs/close")
end
if fs.exists("manos_programs/startsharing") then
    fs.delete("manos_programs/startsharing")
end
if fs.exists("manos_programs/stopsharing") then
    fs.delete("manos_programs/stopsharing")
end
-- END
--Delete old traces of the os
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
if fs.exists("sheets.lua") then
    fs.delete("sheets.lua")
end
if fs.exists("quarry_manager.lua") then
    fs.delete("quarry_manager.lua")
end
if fs.exists("sharing_manager.lua") then
    fs.delete("sharing_manager.lua")
end
-- END
shell.run("wget https://raw.githubusercontent.com/lukacat10/ManOS/master/manos.lua")
shell.run("mkdir manos_dir")
shell.run("wget https://raw.githubusercontent.com/lukacat10/ManOS/master/manos_dir/quarry_manager.lua manos_dir/quarry_manager.lua")
shell.run("wget https://raw.githubusercontent.com/lukacat10/ManOS/master/manos_dir/sharing_manager.lua manos_dir/sharing_manager.lua")
shell.run("wget https://raw.githubusercontent.com/lukacat10/ManOS/master/manos_dir/sheets.lua manos_dir/sheets.lua")
shell.run("pastebin get https://pastebin.com/iwc51FGa manos_programs/open")
shell.run("pastebin get https://pastebin.com/DNFCQ38i manos_programs/close")
shell.run("pastebin get https://pastebin.com/qt4v7tKt manos_programs/startsharing")
shell.run("pastebin get https://pastebin.com/BvdBz8bP manos_programs/stopsharing")
if fs.exists("json") ~= true then
    shell.run("pastebin get 4nRg9CHU json")
end
if fs.exists("startup") then
    fs.delete("startup")
elseif fs.exists("startup.lua") then
    fs.delete("startup.lua")
end
fs.move("manos.lua", "startup")
os.reboot()