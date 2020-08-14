_PROJECT_REVISION_VERSION = "0.1"
--[[
    NAMING CONVENTION: 
    globals : [_][NAMEINFULLCAPS] -- wont need those often tho lol 
    we use camelCase for most stuff
    PascalCase for modules/metatables which we treat like classes (FerocityManager, ComboManager, Q , W , E ,R ... )
    logical prefix ([is]Attack, [can]Cast() , [will]Hit(),)
    for *complex* loops / long loops or functions with many loops  / or just stuff where we got many nested stuff which can be overwhelming to look at
    make a comment at each end which loop ends eg : 
    for i,v in ipairs(t) do
      if type(v) == "string" then
        ...lots of code here...
      end -- if string
    end -- for each t


    some problems we encouter on rengar: 
   1. how do we manage ferocity? 
    1.1 how will we communicate the ferocity usement from one spell to another eg : Q got empowered prio  how do we "tell" W to be stopped till Q got casted

    suggestions: 
    Maybe burst on selected target instead of hotkey?

  
]]
chat.print("Project Revision injected Ver[".._PROJECT_REVISION_VERSION.."]")
module.load("ProjectRevision", player.charName .."/".. player.charName)
