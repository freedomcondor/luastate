local PrintState = require('PrintState')

--local CountState = PrintState:create()

CountState = {}
function CountState:create(configuration)
   local instance = PrintState:create(configuration)
   setmetatable(instance, self)
   self.__index = self

   return instance
end

function CountState:method(parent)
   PrintState.method(self)

   --Add a transition
   if parent.transitions['count3'] == nil then  
      parent.transitions['count3'] = 
      {
         condition = function(dt) return dt.i==3 end,
         from = 'a', to = 'b',
      }
   end

   --print(self.data.string,parent.data.i)  -- for debug
   parent.data.i = parent.data.i + 1
end

return CountState
