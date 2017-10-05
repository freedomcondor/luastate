local State = require('State')

--local PrintState = State:create()
   -- don't need to do this because it is done in create()

PrintState = {}
function PrintState:create(configuration)
   local instance = State:create(configuration)
   setmetatable(instance, self)
   self.__index = self

   instance.data.text = configuration.text

   --[[
   instance.method =  function (self)
                        print(self.data.string)
                     end
   --]]

   return instance
end

---[[
function PrintState:method()
   print(self.data.text)
end
--]]

return PrintState
