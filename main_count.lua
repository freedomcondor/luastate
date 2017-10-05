local State = require('State')
local printState = require('PrintState')
local countState = require('CountState')

local machine = State:create
{		-- ({
	id = "just a machine",
	substates = 
	{	
		--EXIT = State.EXIT,
		a = "a",
		b = "b",
		c = printState:create{string = "Michael"},
		d = printState:create{string = "said"},
		e = State:create
			{
				id = "substate",
				substates = 
				{
					a = countState:create{string = "I"},
					b = countState:create{string = "am"},
					c = countState:create{string = "Harry"},
				--	EXIT = State.EXIT,
				},
				initial_state = 'a',
				transitions = 
				{
					--{condition = function(dt) return dt.i==3 end, 
					--	from = 'a', to = 'b'},
						--this condition is added in CountState.method()

					{condition = function(dt) return dt.i==6 end,
						from = 'b', to = 'c'},
					{condition = function(dt) return dt.i==9 end,
						from = 'c', to = 'EXIT'},
				},
				data = {i = 0}
			},
	},
	initial_state = 'a',
	transitions =
	{
		{condition = function (dt) return true end,from = 'a', to = 'b'},
		{condition = function (dt) return true end,from = 'b', to = 'c'},
		{condition = function (dt) return true end,from = 'c', to = 'd'},
		{condition = function (dt) return true end,from = 'd', to = 'e'},
		{condition = function (dt) return true end,from = 'e', to = 'EXIT'},
	},
}		--})

machine:step()
