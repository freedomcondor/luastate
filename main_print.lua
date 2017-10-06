local State = require('State')
local printState = require('PrintState')

options = 
{     -- ({
   id = "just a machine",
   substates = {  
      a = "a",  b = "b", 
      c = printState:create{text = "Michael"},
      d = printState:create{text = "said"},
      e = State:create{
            id = "substate",
            substates = {
               a = printState:create{text = "I"},
               b = printState:create{text = "am"},
               c = printState:create{text = "Harry"},  },
            --initial = 'a',
            transitions = { {condition = function(dt) return true end, from = 'a', to = 'b'},
                        {condition = function(dt) return true end, from = 'INIT', to = 'a'}, 
                        {condition = function(dt) return true end, from = 'b', to = 'c'}, 
                        {condition = function(dt) return true end, from = 'c', to = 'EXIT'}, 
                       },
      }, -- end of e create
   }, -- end of substates
   initial = 'a',
   transitions ={ {condition = function (dt) return true end,from = 'a', to = 'b'},
               {condition = function (dt) return true end,from = 'b', to = 'c'},
               {condition = function (dt) return true end,from = 'INIT', to = 'a'},
               {condition = function (dt) return true end,from = 'c', to = 'd'},
               {condition = function (dt) return true end,from = 'd', to = 'e'},    
               {condition = function (dt) return true end,from = 'e', to = 'EXIT'},
             },
}     --})

local machine = State:create(options)
local machine2 = State:create(options)


print("1")
machine:stepSingle()
print("2")
machine:stepSingle()
print("3")
machine:stepSingle()
print("4")
machine:stepSingle()
print("5")
machine:stepSingle()
print("6")
machine:stepSingle()
print("7")
machine:stepSingle()
print("8")
machine:stepSingle()
print("9")
machine:stepSingle()
print("10")
machine:stepSingle()
print("11")
machine:stepSingle()
print("12")
machine:stepSingle()
print("13")
machine:stepSingle()
