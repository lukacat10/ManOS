local env = setmetatable( {}, { __index = _ENV } )
local function f()
    local _ENV = env
    if setfenv then
        setfenv( 1, env )
    end
--Classes
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


--Exceptions
local __f,__err=load("local e\
local function t(a)\
for o=1,#a do if\
a[o].catch==e.name or a[o].default or a[o].catch==e.class then return a[o].handler(e)end end return Exception.throw(e)end\
class\"Exception\"{name=\"undefined\",data=\"undefined\",trace={}}\
function Exception:Exception(a,o,i)self.name=a self.data=o self.trace={}i=(i or 1)+2 if\
i>2 then\
for n=1,5 do\
local s=select(2,pcall(error,\"\",i+n)):gsub(\": $\",\"\")if s==\"pcall\"or s==\"\"then break else self.trace[n]=s end end end end\
function Exception:getTraceback(a,o)a=a or\"\"o=o or\"\\n\"\
parameters.check(2,\"initial\",\"string\",a,\"delimiter\",\"string\",o)if#self.trace==0 then return\"\"end return\
a..table.concat(self.trace,o)end\
function Exception:getData()\
if\
type(self.data)==\"string\"or class.isClass(self.data)or class.isInstance(self.data)then return\
tostring(self.data)else return textutils.serialize(seld.data)end end\
function Exception:getDataAndTraceback(a)\
parameters.check(1,\"indent\",\"number\",a or 1)\
return self:getData()..\
self:getTraceback(\"\\n\".. (\" \"):rep(a or 1)..\"in \",\
\"\\n\".. (\" \"):rep(a or 1)..\"in \")end\
function Exception:tostring()return tostring(self.name)..\
\" exception:\\n  \"..self:getDataAndTraceback(4)end function Exception.thrown()return e end\
function Exception.throw(a,o,i)\
if class.isClass(a)then a=a(o,\
(i or 1)+1)elseif type(a)==\"string\"then\
a=Exception(a,o,(i or 1)+1)elseif not class.typeOf(a,Exception)then return\
Exception.throw(\"IncorrectParameterException\",\
\"expected class, string, or Exception e, got \"..class.type(a))end e=a\
error(\"SHEETS_EXCEPTION\\nPut code in a try block to catch the exception.\",0)end\
function Exception.try(a)local o,i=pcall(a)\
if not o and\
i==\"SHEETS_EXCEPTION\\nPut code in a try block to catch the exception.\"then return t end return error(i,0)end function Exception.catch(a)\
return function(t)return{catch=a,handler=t}end end function Exception.default(t)\
return{default=true,handler=t}end","exceptions.Exception",nil,_ENV)if not __f then error(__err,0)end __f()
local __f,__err=load("class\"IncorrectParameterException\"extends\"Exception\"\
function IncorrectParameterException:IncorrectParameterException(e,t)return\
self:Exception(\"IncorrectParameterException\",e,t)end","exceptions.IncorrectParameterException",nil,_ENV)if not __f then error(__err,0)end __f()
local __f,__err=load("class\"IncorrectConstructorException\"extends\"Exception\"\
function IncorrectConstructorException:IncorrectConstructorException(e,t)return\
self:Exception(\"IncorrectConstructorException\",e,t)end","exceptions.IncorrectConstructorException",nil,_ENV)if not __f then error(__err,0)end __f()
local __f,__err=load("class\"ResourceLoadException\"extends\"Exception\"\
function ResourceLoadException:ResourceLoadException(e,t)return\
self:Exception(\"ResourceLoadException\",e,t)end","exceptions.ResourceLoadException",nil,_ENV)if not __f then error(__err,0)end __f()
local __f,__err=load("class\"ThreadRuntimeException\"extends\"Exception\"\
function ThreadRuntimeException:ThreadRuntimeException(e,t)return\
self:Exception(\"ThreadRuntimeException\",e,t)end","exceptions.ThreadRuntimeException",nil,_ENV)if not __f then error(__err,0)end __f()









local sheets = dofile "/manos_dir/sheets.lua"
local colour = sheets.colour
local quarryManager = dofile "/manos_dir/quarry_manager.lua"
local sharingManager = dofile "/manos_dir/sharing_manager.lua"


class "CandC" {
    application = nil,
    parent = nil,
    errorText = nil,
    exitBtn = nil,
    updateBtn = nil,
    quarry = nil,
    sharing = nil
}

function CandC:CandC(application, parent)
    self.application = application
    self.parent = parent

    self.errorText = sheets.Text(0, self.parent.height - 1, self.parent.width, 1, "")
    self.errorText.style:setField("textColour", colour.red)
    self.errorText.style:setField("colour", colour.transparent)
    parent:addChild( self.errorText )

    self:initExitBtn()
    self:initUpdateBtn()
    self:initQuarryControl()
    self:initSharingControl()
    print(self.parent.width)
    self.application:run()
end

function CandC:initExitBtn()
    self.exitBtn = sheets.Button( self.parent.width - 1, 0, 1, 1, "X" )
    self.exitBtn.style:setField("textColour", colour.red)
    self.exitBtn.style:setField("colour", colour.transparent)
    self.exitBtn.style:setField("colour.pressed", colour.lightGrey)
    self.parent:addChild( self.exitBtn )

    self.exitBtn.application = self.application
    function self.exitBtn:onClick()
        self.application:stop()
    end
end

function CandC:initUpdateBtn()
    self.updateBtn = sheets.Button( self.parent.width - 7, 0, 1, 1, "Update" )
    self.updateBtn.style:setField("textColour", colour.white)
    self.updateBtn.style:setField("colour", colour.lightGrey)
    self.updateBtn.style:setField("colour.pressed", colour.grey)
    self.parent:addChild( self.updateBtn )

    self.updateBtn.application = self.application
    function self.updateBtn:onClick()
        shell.run("wget https://raw.githubusercontent.com/lukacat10/ManOS/master/installer.lua")
        shell.run("installer")
        self.application:stop()
    end
end

function CandC:initQuarryControl()
    self.quarry = sheets.Checkbox(1, 1, false)
    self.quarry.style:setField("colour", colour.red)
    self.quarry.style:setField("colour.checked", colour.green)
    self.quarry.style:setField("checkColour", colour.transparent)
    self.parent:addChild( self.quarry )
    local quarryText = sheets.Text(3, 1, 19, 1, "Quarry   Realtime: ")
    self.parent:addChild( quarryText )

    -- TODO quarryStatus should be managed only by quarryManager
    local quarryStatus = sheets.Text(22, 1, 7, 1, "offline")
    quarryStatus.style:setField("colour", colour.red)
    self.parent:addChild( quarryStatus )

    local quarryManagerInstance = quarryManager.QuarryManager(self.quarry, quarryStatus)
    quarryManagerInstance:setErrorText(self.errorText)
end

function CandC:initSharingControl()
    self.sharing = sheets.Checkbox(1, 3, false)
    self.sharing.style:setField("colour", colour.red)
    self.sharing.style:setField("colour.checked", colour.green)
    self.sharing.style:setField("checkColour", colour.transparent)
    self.parent:addChild( self.sharing )

    local sharingText = sheets.Text(3, 3, 20, 1, "Sharing   Realtime: ")
    self.parent:addChild( sharingText )

    local sharingStatus = sheets.Text(22, 3, 7, 1, "offline")
    sharingStatus.style:setField("colour", colour.red)
    self.parent:addChild( sharingStatus )

    local sharingManagerInstance = sharingManager.SharingManager(self.sharing, self.sharingStatus)
    sharingManagerInstance:setErrorText(self.errorText)
end

class "Main" {
    application = nil,
    candcPanel = nil
}
function Main:Main()
    self.application = sheets.Application()
    self.candcPanel = sheets.Panel(0, 0, self.application.screen.width, self.application.screen.height)
    self.candcPanel.style:setField("colour", colour.white)
    self.application.screen:addChild(self.candcPanel)
    cc = CandC(self.application, self.candcPanel)
end
Main()



end
f()
local sheets = {}
for k, v in pairs( env ) do
    sheets[k] = v
end


 return sheets