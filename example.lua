-- Example program demonstrating the use of mixins --

local entity = require("entity")
local mixin = require("mixin")

local 	mixinPrintHello = mixin.new("mixinPrintHello")			

		function mixinPrintHello:onPrint()									
			print("Hello")
		end

		
local	mixinPrintWorld = mixin.new("mixinPrintWorld")

		function mixinPrintWorld:onPrint()
			print("World!")
		end
		

local 	ent = entity.new()

		ent:addmixin(mixinPrintHello)
		ent:addmixin(mixinPrintWorld)
		
		ent:onPrint()
		
		-- outputs: 
		-- Hello
		-- World!
		
local 	ent2 = entity.new()

		ent2:addmixin(mixinPrintHello)
		
		ent2:onPrint()
		
		-- outputs:
		-- Hello
		
local	ent3 = entity.new()

		ent3:addfunction("onPrint", function()
			print("Goodbye, world!")
		end)
		
		ent3:onPrint()
		
		-- outputs:
		-- Goodbye, world!
		
io.read()