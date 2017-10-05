--[[
Explanations:

A State should have:
{
   class = "State"      
   EXIT = {flag}
         those are flags
   step()            <a function>
   data =            <a table>
   {
      to be filled..
   }
         step is necessary
         data is necessary default {}, (implemented in state:create)

   the other is all optional:

   id = "xxx"     <a string>  
   substates =       <a table>
   {
      statename = the state   statename is the index,    <state can be anything>
      ...
   }

   transitions =    <a table>
   {
      1.    <a table>
      {
         condition = xxx   <a function returning true of false>
         from = "statename"
         to = "statename"
      }

      2.    <a table>
      {
         condition = xxx   <a function returning true of false>
         from = "statename"
         to = "statename"
      }

      1,2,3.. are indexes, you can also add transition with string index like 
            lalala = {conditiong = xxx, from = xxx, to = xxx}

      ...
   }


   current = the state        <can be anything> 
   method = function (self)    <State:method>
}
--]]

-- To Inherite/Create a State_object  a = State.create(xxx)
-- then a should have {class, EXIT, data={}, step(), and what ever xxx defines}
--[[
xxx (options) would be like this:

options  <a table>
{
   these things are all optional:

   id = "xxx"
   substates =    <a table>
   {
      statename = the state   statename is the id, state can be anything
      ...
   }

   initial_state = statename   <string>  the statename  
            if there is substates, must assign an initial state

   transitions =    <a table>
   {
      1.    <a table>
      {
         condition = xxx   <a function returning true of false>
         from = statename
         to = statename
      }

      2.    <a table>
      {
         condition = function (dt)   <a function returning true of false>
            <any variable inside should be writen as dt.i, dt.x>
         from = "statename"
         to = "statename"
      }

      to exit, a transition should have:
      {
         xxx
         to = 'EXIT'
      }

      ...
   }

   data =     <a table>
   {
      to be filled..
   }
}
--]]

-- Table State would act as a class
local State = 
{
   class = "State",
   EXIT = {exitflag="flagflag"}, 
            -- this is just a flag, {exitflag="flagflag"} can be anything unique
   data = {}
}
State.__index = State            
--setmetatable(State,State)    -- don't do that, it will enter a loop when trying to find a index

function State:create(options)
   -- Inherite
   local state_object = {}
   setmetatable(state_object, self)
   self.__index = self
      --the metatable of state_object would be whoever owns this create
      --so you can :  a = State:create();  b = a:create();  grandfather-father-son

   -- Asserts
   if options == nil then return state_object end  -- return an State object with only basic thing
   if options.substates ~= nil and options.initial_state == nil then
      print("bad create option: There are substates, but initial not assigned\n") return nil end
      -- check condition
         -- to be filled, 
         -- condition is optional
         -- but if you like you can also check the structure of conditions, 

   -- add options into state object
   state_object.id = options.id
   state_object.substates = options.substates
   state_object.transitions = options.transitions
   state_object.method = options.method
      -- those may need to be changed to table.copy,
      -- because if do something like
      -- options = {xxxx}
      --  a.create(options)
      --  b.create(options)
      -- then a and b may share the same memery
   --state_object.data = options.data or {}
      -- this is fine if do not inherite data from fathers, 
      -- otherwise may need to do something like this:
      -- but also care about the memery sharing problem
         ---[[
         state_object.data={}
         for index,value in pairs(self.data) do
            state_object.data[index] = value
         end
            -- equals to table.copy
         if options.data ~= nil then
            for index,_ in pairs(options.data) do
               state_object.data[index] = options.data[index]
            end
         end
         --]]

   if options.substates ~= nil then
      state_object.current = state_object.substates[options.initial_state]
      state_object.substates.EXIT = State.EXIT  -- add an exit substate
   else
      state_object.current = nil
   end

   return state_object
end

function State:step()
   --[[
      explanations:
         three conditions may happen:
         1. the owner of this step is a state with everything (substates..): 
            run it as a normal state, go through all the substates
               for each substates, 2 conditions:
                  1. this substates is a state 
                     if it has a method, run method
                     then run step
                  2. this substates is not a state (a string maybe, do not have a method)
                     if it has method(although it is not a state), run method

         2. It is a state with nothing (no substates, no currents...)
            do nothing (presume its method has run outside before the step)
         3. It is not a state, a string maybe
            do nothing (in fact this condition may not even happen)
   --]]

   --[[
   if self.method ~= nil then    
      self:method(self.data)
   end   
   --]]
      -- have to run method outside step if method need to change transtions, because
      -- self need to be a parameter in method

   --If no substates, do nothing
   if self.substates == nil then
      return -1
   end

   --Go though all substates, for each run method() and step() 
      -- run method(self) if this method changes transtions
   while self.current ~= self.EXIT do
      --if self.current.method ~= nil then self.current:method(self) end
      if type(self.current.method) == 'function' then self.current:method(self) end

      --print("current",self.current)     -- for debug

      if self.current.class == "State" and
         self.current.step ~= nil and 
         type(self.current.step) == "function" then
            self.current:step()
      end

      --check all the condition
      for _, focal_tran in pairs(self.transitions) do 
         -- focal_tran would be a transition table
         if    (type(focal_tran.condition) == 'function' and focal_tran.condition(self.data) or
            type(focal_tran.condition) ~= 'function' and focal_tran.condition   ) and
            self.substates[focal_tran.from] == self.current then
               --print("from:",self.substates[focal_tran.from])   --for debug
               --print("to",self.substates[focal_tran.to])        --for debug
               self.current = self.substates[focal_tran.to]
               break
         end
      end
   end

   return 0
end

return State

