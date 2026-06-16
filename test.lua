local module = {}

function module.Get(obj)
   for _, v in next, obj:GetDescendants() do
      print(v.. ": ".. typeof(v))
   end
end

return module
