local module = {}

function module.Get(obj)
   for _, v in next, obj:GetDecendents() do
      print(v.. ": ".. typeof(v))
   end
end

return module
