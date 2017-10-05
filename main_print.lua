local State = require('State')
local printState = require('PrintState')

options = 
{		-- ({
	id = "just a machine",
	substates = {	
		a = "a",  b = "b", 
		c = printState:create{string = "Michael"},
		d = printState:create{string = "said"},
		e = State:create{
				id = "substate",
				substates = {
					a = printState:create{string = "I"},
					b = printState:create{string = "am"},
					c = printState:create{string = "Harry"},  },
				initial_state = 'a',
				transitions = { {condition = function(dt) return true end, from = 'a', to = 'b'},
								{condition = function(dt) return true end, from = 'b', to = 'c'}, 
								{condition = function(dt) return true end, from = 'c', to = 'EXIT'}, 
							  },
		},	-- end of e create
	},	-- end of substates
	initial_state = 'a',
	transitions ={	{condition = function (dt) return true end,from = 'a', to = 'b'},
					{condition = function (dt) return true end,from = 'b', to = 'c'},
					{condition = function (dt) return true end,from = 'c', to = 'd'},
					{condition = function (dt) return true end,from = 'd', to = 'e'},    
					{condition = function (dt) return true end,from = 'e', to = 'EXIT'},
				 },
}		--})

local machine = State:create(options)
local machine2 = State:create(options)


machine:step()
