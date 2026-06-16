local module = {}

local players = game:GetService("Players")

function module.Get(obj)
   for _, v in next, obj:GetChildren() do
      if not players:FindFirstChild(v.Name) then
         print(v.Name.. ": ".. v.ClassName)
      else
         error(v.Name.. ": ".. v.ClassName)
      end
   end
end

return module
