local module = {}

function module.Get(obj)
   for _, v in next, obj:GetDescendants() do
      print(v.Name.. ": ".. v.ClassName)
   end
end

return module
