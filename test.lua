local module = {}

local players = game:GetService("Players")

function module.Get(obj)
   print("-----------------------------------------")
   for _, v in next, obj:GetChildren() do
      if not players:FindFirstChild(v.Name) then
         print(v.Name.. ": ".. v.ClassName)
      else
         warn(v.Name.. ": ".. v.ClassName)
      end
   end
   print("-----------------------------------------")
end

return module
