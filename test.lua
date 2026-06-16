local module = {}

function module.Get(obj)
   for _, v in next, obj:GetDescendants() do
      print(v.. ": ".. v.ClassName)
   end
end

return module
