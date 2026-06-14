local module = {
    ActiveHooks = {},
    CachedRemotes = {}
}

local originalNamecall = nil

local function findRemote(name)
    if module.CachedRemotes[name] then return module.CachedRemotes[name] end
    
    for _, desc in ipairs(game:GetDescendants()) do
        if (desc:IsA("RemoteEvent") or desc:IsA("RemoteFunction")) and desc.Name == name then
            module.CachedRemotes[name] = desc
            return desc
        end
    end
    return nil
end

local function startGlobalHook()
    if originalNamecall then return end
    
    originalNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local args = {...}
        local method = getnamecallmethod()
        local isRemoteCall = (method == "FireServer" or method == "InvokeServer")
        
        if isRemoteCall then
            local remoteName = tostring(self.Name)
            
            if module.ActiveHooks[remoteName] then
                
                local customReturn = module.ActiveHooks[remoteName](self, args)
                
                if type(customReturn) == "table" then
                    args = customReturn
                end
            end
        end
        
        return originalNamecall(self, unpack(args))
    end))
end

function module.HookRemote(remoteName, callback)
    if not findRemote(remoteName) then
        return "remote not found"
    end
    
    if type(callback) ~= "function" then
        return "invalid callback"
    end
    
    startGlobalHook()
    module.ActiveHooks[remoteName] = callback
    return "success"
end

function module.DehookRemote(remoteName)
    if module.ActiveHooks[remoteName] then
        module.ActiveHooks[remoteName] = nil
        return "success"
    else
        return "no active hook found"
    end
end

return module
