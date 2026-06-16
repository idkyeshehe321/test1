local module = {}

function module.Get(obj)
   return obj:GetDecendents() 
end

return module
