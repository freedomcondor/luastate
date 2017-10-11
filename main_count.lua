local State = require('State')
local printState = require('PrintState')
local countState = require('CountState')

local machine = State:create
{     -- ({
   id = "just a machine",
   substates = 
   {  
      --EXIT = State.EXIT,
      a = State:create{method = function()print("haha");return 'b' end},
      b = "b",
      c = printState:create{text = "Michael"},
      d = printState:create{text = "said"},
      e = State:create
         {
            id = "substate",
            substates = 
            {
               a = countState:create{text = "I"},
               b = countState:create{text = "am"},
               c = countState:create{text = "Harry"},
            -- EXIT = State.EXIT,
            },
            initial = 'a',
            transitions = 
            {
               --{condition = function(dt) return dt.i==3 end, 
               -- from = 'a', to = 'b'},
                  --this condition is added in CountState.method()

               {condition = function(dt) return dt.i==6 end,
                  from = 'b', to = 'c'},
               {condition = function(dt) return dt.i==9 end,
                  from = 'c', to = 'EXIT'},
               --{condition = function(dt) return true end,
                --  from = 'INIT', to = 'a'},
            },
            data = {i = 0},
            method = function()
                        print("I am the entry of the substate");
                        return 0
                     end,
         },
      f = printState:create{text = "finish"},
   },
   initial = 'a',
   transitions =
   {
      --{condition = function (dt) return true end,from = 'INIT', to = 'a'},
      --{condition = function (dt) return true end,from = 'a', to = 'b'},
      --{condition = true,from = 'a', to = 'b'},

      --{condition = function (dt) return true end,from = 'b', to = 'c'},
      {condition = true,from = 'b', to = 'c'},
      --{condition = function (dt) return true end,from = 'c', to = 'd'},
      {condition = true,from = 'c', to = 'd'},
      {condition = function (dt) return true end,from = 'd', to = 'e'},
      {condition = function (dt) return true end,from = 'e', to = 'f'},
      {condition = function (dt) return true end,from = 'f', to = 'EXIT'},
   },
}     --})

--machine:step()
---[[
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
print("14")
machine:stepSingle()
print("15")
machine:stepSingle()
print("16")
machine:stepSingle()
print("17")
machine:stepSingle()
--]]
