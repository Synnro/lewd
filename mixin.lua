--[[
=======================================================================================
	mixin object
	
	About:		The mixin object provides functionality to an entity.
	
	Functions:	mixin.new( type )	- returns a new instance of our mixin object
				mixin:init()		- overridable method that is called once our mixin is
										added to our entity
		
========================================================================================
]]--
local mixin = {}

-- mixin.new( tag ) 
-- returns a new instance of the mixin
-- the tag parameter is a string that identifies the mixin
function mixin.new( tag )
	if not tag then error( "new mixin requires a tag..." ) end
	return setmetatable( { tag = tag }, { __index = mixin } )
end

-- mixin:init()
-- override this in your mixin implementation
-- called immediately after the mixin is added to the entity
function mixin:init()
end

return mixin