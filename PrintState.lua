local State = require('State')

--local printState = State:create()

printState = {}
function printState:create(options)
	local printState_ob = State:create(options)
	setmetatable(printState_ob, self)
	self.__index = self

	printState_ob.data.string = options.string

	--[[
	printState_ob.method = 	function (self)
								print(self.data.string)
							end
	--]]

	return printState_ob
end

---[[
function printState:method()
	print(self.data.string)
end
--]]

return printState
