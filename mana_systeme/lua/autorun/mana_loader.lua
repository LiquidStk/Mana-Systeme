--//// Système crée par Liquid_stk#7729 \\\\--

Mana = Mana or {}
Mana.config = Mana.config or {}

-- Loader -- 

local rootDir = "mana_systeme"

local function AddFile(File, dir)
    local fileSide = string.lower(string.Left(File , 3))

    if SERVER and fileSide == "sv_" then
        include(dir..File)
    elseif fileSide == "sh_" then
        if SERVER then 
            AddCSLuaFile(dir..File)
        end
        include(dir..File)
    elseif fileSide == "cl_" then
        if SERVER then 
            AddCSLuaFile(dir..File)
        elseif CLIENT then
            include(dir..File)
        end
    end
end

local function IncludeDir(dir)
    dir = dir .. "/"
    local File, Directory = file.Find(dir.."*", "LUA")

    for k, v in ipairs(File) do
        if string.EndsWith(v, ".lua") then
            AddFile(v, dir)
        end
    end
    
    for k, v in ipairs(Directory) do
        IncludeDir(dir..v)
    end

end
IncludeDir(rootDir)

include("config.lua")
AddCSLuaFile("config.lua")

-- Responsive -- 

function W(pixels, base)
    base = base or 1920
    return ScrW()/(base/pixels)
end


function H(pixels, base)
    base = base or 1080
    return ScrH()/(base/pixels)
end

-- fonts --

if CLIENT then 
    
    local font_mana = "I Love Salmon"

    surface.CreateFont("font_LiquidMana", {

        font = font_mana,
        size = W(25),
        weight = 200,
        antialias = true
    })

    surface.CreateFont("font_LiquidMana1", {

        font = font_mana,
        size = W(40),
        weight = 200,
        antialias = true
    })

    surface.CreateFont("font_LiquidMana2", {

        font = font_mana,
        size = W(55),
        weight = 200,
        antialias = true
    })

    surface.CreateFont("font_LiquidMana3", {

        font = font_mana,
        size = W(16),
        weight = 200,
        antialias = true
    })

    surface.CreateFont("font_LiquidMana4", {

        font = font_mana,
        size = W(20),
        weight = 200,
        antialias = true
    })

end

-- Sound --

Mana.Sound = {

    typing_sound = Sound("buttons/typing.wav")

}

-- Materials -- 

Mana.Materials = {

    close_button = Material("buttons-mana/close.png", "noclamp smooth")

}


-----------
