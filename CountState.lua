local printState = require('PrintState')

--local countState = printState:create()

countState = {}
function countState:create(options)
	local countState_ob = printState:create(options)
	setmetatable(countState_ob, self)
	self.__index = self

	return countState_ob
end

function countState:method(father)
	printState.method(self)

	--Add a transition
	if father.transitions['count3'] == nil then	
		father.transitions['count3'] = 
		{
			condition = function(dt) return dt.i==3 end,
			from = 'a', to = 'b',
		}
	end

	--print(self.data.string,father.data.i)  -- for debug
	father.data.i = father.data.i + 1
end

return countState
