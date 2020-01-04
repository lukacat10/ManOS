local env = setmetatable( {}, { __index = _ENV } )
local function f()
    local _ENV = env
    if setfenv then
        setfenv( 1, env )
    end
local __f,__err=load("class={}local e=setmetatable({},{__index=class})local t={}local a={}\
local o\
local i={__add=true,__sub=true,__mul=true,__div=true,__mod=true,__pow=true,__unm=true,__len=true,__eq=true,__lt=true,__lte=true,__tostring=true,__concat=true}local function n(d)return\"[Class] \"..d:type()end local function s(d,l)return tostring(d)..\
tostring(l)end\
local function h(d)if not o then\
return error\"no class to define\"end for l,u in pairs(d)do o[l]=u end o=nil end\
local function r(d,l)local u={}if l.super then u.super=r(d,l.super)end\
setmetatable(u,{__index=function(c,m)\
if type(l[m])==\
\"function\"then\
return function(f,...)if f==u then f=d end d.super=u.super local w={l[m](f,...)}\
d.super=u return unpack(w)end else return l[m]end end,__newindex=l,__tostring=function(c)\
return\
\"[Super] \"..tostring(l)..\" of \"..tostring(d)end})return u end\
function e:new(...)local d={__index=self,__INSTANCE=true}\
local l=setmetatable({class=self,meta=d},d)if self.super then l.super=r(l,self.super)end for c,m in\
pairs(self.meta)do if i[c]then d[c]=m end end if d.__tostring==n then function d:__tostring()return\
self:tostring()end end function l:type()return\
self.class:type()end function l:typeOf(c)\
return self.class:typeOf(c)end\
if not self.tostring then function l:tostring()return\
\"[Instance] \"..self:type()end end local u=self while u do\
if u[u.meta.__type]then u[u.meta.__type](l,...)break end u=u.super end return l end function e:extends(d)self.super=d self.meta.__index=d end function e:type()return\
tostring(self.meta.__type)end function e:typeOf(d)return\
d==self or(self.super and\
self.super:typeOf(d))or false end\
function class:new(d)\
if type(\
d or self)~=\"string\"then return\
error(\"expected string class name, got \"..type(d or self))end\
local l={__index=e,__CLASS=true,__tostring=n,__concat=s,__call=e.new,__type=d or self}local u=setmetatable({meta=l},l)t[d]=u o=u _ENV[d]=u return\
function(c)if not o then return\
error\"no class to define\"end for m,f in pairs(c)do o[m]=f end o=nil end end\
function class.type(d)local l=type(d)if l==\"table\"then\
pcall(function()local u=getmetatable(d)\
l=(\
(u.__CLASS or u.__INSTANCE)and d:type())or l end)end return l end\
function class.typeOf(d,l)\
if type(d)==\"table\"then\
local u,c=pcall(function()\
return getmetatable(d).__CLASS or\
getmetatable(d).__INSTANCE or error()end)return u and d:typeOf(l)end return false end function class.isClass(d)\
return pcall(function()\
if not getmetatable(d).__CLASS then error()end end),nil end\
function class.isInstance(d)return\
pcall(function()if not\
getmetatable(d).__INSTANCE then error()end end),nil end setmetatable(class,{__call=class.new})\
function extends(d)\
if not o then return\
error\"no class to extend\"elseif not t[d]then return\
error(\"no such class '\"..tostring(d)..\"'\")end o:extends(t[d])return h end\
function interface(d)a[d]={}_ENV[d]=a[d]\
return function(l)if type(l)~=\"table\"then return\
error(\"expected table t, got \"..class.type(l))end\
_ENV[d]=l a[d]=l end end\
function implements(d)\
if not o then return error\"no class to modify\"elseif not a[d]then return error(\"no interface by name '\"..\
tostring(d)..\"'\")end for l,u in pairs(a[d])do o[l]=u end return h end","lib.class",nil,_ENV)if not __f then error(__err,0)end __f()

local List = dofile("/manos_dir/list.lua")
os.loadAPI("/manos_dir/json.lua")

class "Task" {
    checkBox = nil,
    statusText = nil,
    errorText = nil
}

function Task:Task( parent, sheets, name, func, ...)
    self.parent = parent
    self.sheets = sheets
    self.panel = self.sheets.Panel(0, 0, parent.width, 1)
    self.name = name
    self.corout = coroutine.create(func)
    self.args = ...
    self.parent:addChild(self.panel)
    self:initUI()
end

function Task:initUI()
    self.button = self.sheets.Button(0, 0, 1, 1, "X")
    self.button.style:setField("colour", self.sheets.colour.transparent)
    self.button.style:setField("colour.pressed", self.sheets.colour.grey)
    self.button.style:setField("textColour", self.sheets.colour.grey)
    self.button.style:setField("textColour.pressed", self.sheets.colour.white)
    self.panel:addChild(self.button)

    self.name = self.sheets.Text(2, 0, self.panel.width - 2, 1, self.name)
    self.name.style:setField("colour", self.sheets.colour.transparent)
    self.panel:addChild(self.name)
    self.is_attached = false

end
function Task:setIndex(index)
    if index % 2 == 0 then
        self.panel.style:setField("colour", self.sheets.colour.white)
    else
        self.panel.style:setField("colour", self.sheets.colour.lightGrey)
    end
    self.panel:setY(index)
    self.index = index
end
function Task:remove()
    self.panel:remove()
end


class "TaskManager" {
    checkBox = nil,
    statusText = nil,
    errorText = nil
}

--function TaskManager:setErrorText( errorText )
--    self.errorText = errorText
--end

function TaskManager:TaskManager( application, parent, sheets, cc)
    self.cc = cc
    self.application = application
    self.parent = parent
    self.sheets = sheets
    self.taskList = List.List()
    self.tasksToKill = {}
    self:initUI()
    self:loadStartupTasks()
end

function TaskManager:initUI()
    self.window = self.sheets.Panel(0, 0, self.application.screen.width, self.application.screen.height)
    self.window.style:setField("colour", self.sheets.colour.black)

    self.exitBtn = self.sheets.Button(self.application.screen.width - 1, 0, 1, 1, "X")
    self.exitBtn.style:setField("colour", self.sheets.colour.transparent)
    self.exitBtn.style:setField("colour.pressed", self.sheets.colour.grey)
    self.window:addChild(self.exitBtn)
    self.exitBtn.taskMgr = self
    function self.exitBtn:onClick()
        self.taskMgr:hide()
    end
    
    self.panel = self.sheets.Panel(0, 0, self.application.screen.width + 10, self.application.screen.height + 10)
    self.panel.style:setField("colour", self.sheets.colour.white)

    self.scroll = self.sheets.ScrollContainer(0, 1, self.window.width, self.window.height - 1, self.panel)
    self.window:addChild(self.scroll)
    self.parent:addChild(self.window)
    self.window:setZ(0)
end
function TaskManager:hide()
    --self.window:remove()
    self.window:setZ(0)
    --self.cc:show()
end
function TaskManager:show()
    --self.parent:addChild(self.window)
    self.window:setZ(15)
end

function TaskManager:addTask(name, func, ...)
    taskToAdd = Task(self.panel, self.sheets, name, func, ...)
    newIndex = self.taskList.count
    taskToAdd:setIndex(newIndex)
    newnode = self.taskList:add(taskToAdd)
    taskKillBtn = taskToAdd.button
    taskKillBtn.newnode = newnode
    taskKillBtn.taskList = self.taskList
    taskKillBtn.task = taskToAdd
    function taskKillBtn:onClick()
        self.taskList:removeNode(self.newnode)
        self.task:remove()
    end
end

function TaskManager:run()
    currentNode = self.taskList.rootNode
    while currentNode ~= nil do
        coroutine.resume(currentNode.value.corout, currentNode.value.args)
        currentNode = currentNode.next
    end

    while true do
        local event = { coroutine.yield() }
        if event[1] == "terminate" then
            return
        end
        currentNode = self.taskList.rootNode
        index = 0
        while currentNode ~= nil do
            if currentNode.value.index ~= index then
                currentNode.value:setIndex(index)
            end
            coroutine.resume(currentNode.value.corout, table.unpack(event))
            
            currentNode = currentNode.next
            index = index + 1
        end
    end
end
function TaskManager:loadStartupTasks()
    file = fs.open("/startup_programs.lua", "r")
    fileContent = file.readAll()
    file.close()
    fileData = json.decode(fileContent)
    for k,v in ipairs(fileData) do
        func = dofile(v["abs_path"])
        args = v["args"]
        if args ~= nil then
            args = table.unpack(args)
        end
        self:addTask(v["name"], func, args)
    end
end

end

f()
local sheets = {}
for k, v in pairs( env ) do
    sheets[k] = v
end


 return sheets