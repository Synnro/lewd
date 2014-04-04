--[[
=======================================================================================
	entity object
	
	About:		The entity object is a basic container for mixins which
				provide the entity with functionality. When a mixin is 
				added to the entity, its functions are copied onto the
				entity without overriding any of the entities previous 
				functionality.

	Functions:	entity.new()					- returns a new instance of an entity
				entity:addmixin(mixin)			- adds the mixin to the entity
				entity:hasmixin(mixin)			- returns true if the entity contains the given mixin
				entity:addfunction(name, fn)	- adds the function to the entity
				
========================================================================================
]]--

local unpack, type, pairs, setmetatable = unpack, type, pairs, setmetatable

local entity = {}

-- entity.new() 
-- returns a new instance of the entity 
function entity.new()
	local t = {
		__functions = {},
		__tags = {}
	  }
	return setmetatable(t, {__index = entity})
end

-- entity:addmixin( mixin )
-- adds the mixin to the entity, automatically copying all
-- functions from the mixin to the entity and running the mixin:init() function
function entity:addmixin( mixin )
	if not mixin.tag then error( "failed to add mixin..." ) return end
	self.__tags[mixin.tag] = true
	for name, fn in pairs( mixin ) do
		self:addfunction( name, fn )
	end
	mixin.init( self )
end

-- entity:hasmixin( mixin )
-- returns true if the mixin is contained in the entity
function entity:hasmixin( mixin )
	return self.__tags[mixin.tag] or false
end

-- entity:addfunction( name, fn )
-- adds the function to a list of functions with the same name then builds a function to call
-- the functions within that list
function entity:addfunction( name, fn )
	if type( fn ) ~= "function" then return end
	local ftable = self.__functions
	if not ftable[name] then
		ftable[name] = {}
	end
	ftable[name][#ftable[name] + 1] = fn
	self[name] = function( ... )
		local result = {}
		for i = 1, #ftable[name] do
		result[#result + 1] = ftable[name][i]( ... )
		end
		return unpack( result )	
	end
end
return entity