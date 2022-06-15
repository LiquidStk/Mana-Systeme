--//// Système crée par Liquid_stk#7729 \\\\--


-- Création de la DATA (MANA) -- 

util.AddNetworkString("InfoMana")

hook.Add( "PlayerInitialSpawn", "LoadMana", function( ply )

    local SteamID64 = tostring(ply:SteamID64())


    if not file.Exists( "mana_systeme", "DATA" ) then
        file.CreateDir( "mana_systeme" )
    end

    if not file.Exists( "mana_systeme/"..SteamID64, "DATA" ) then
        file.CreateDir( "mana_systeme/"..SteamID64 )
        
            DataTable = { SteamID64 }
        
            local loadData = file.Read( "mana_systeme/"..SteamID64.."/mana_"..SteamID64..".txt")
        
            if loadData then 
                DataTable = util.JSONToTable( loadData )
            end

        
            DataTable[2] = Mana.config.mana_start		-- Mana max
            DataTable[3] = Mana.config.mana_start       -- Mana current 


            local saveData = util.TableToJSON(DataTable)
            file.Write("mana_systeme/"..SteamID64.."/mana_"..SteamID64..".txt", saveData)

    end


    -- Ajout du Mana toutes les x secondes --

    timer.Create("Mana_timer", Mana.config.mana_time_up, 0, function()
        for i, v in ipairs( player.GetAll() ) do
            if v:Alive() then

                local SteamID64 = v:SteamID64()

                DataTable = { SteamID64  } 

                local loadData = file.Read("mana_systeme/"..SteamID64.."/mana_"..SteamID64..".txt")

                if loadData then
                    DataTable = util.JSONToTable( loadData )
                end

                DataTable[2] = DataTable[2] + Mana.config.mana_up
                        
                local saveData = util.TableToJSON(DataTable)
                file.Write("mana_systeme/"..SteamID64.."/mana_"..SteamID64..".txt", saveData )

            end
        end
    end)


    -- Régéneration du MANA -- 


    timer.Create("ManaRegene", Mana.config.mana_time_regene, 0, function()

        for i, v in ipairs( player.GetAll() ) do
            if v:IsPlayer() and v:Alive() then

                DataTable = { v:SteamID64() }

                local loadData = file.Read( "mana_systeme/"..v:SteamID64().."/mana_"..v:SteamID64()..".txt")
                                
                if loadData then 
                    DataTable = util.JSONToTable( loadData )
                end

                if DataTable[3] < DataTable[2] then

                    DataTable = { v:SteamID64() }
                            
                    local loadData = file.Read("mana_systeme/"..v:SteamID64().."/mana_"..v:SteamID64()..".txt")
                                
                    if loadData then 
                        DataTable = util.JSONToTable( loadData )
                    end

                    DataTable[3] = DataTable[2] * Mana.config.mana_regene / 100 + DataTable[3]

                    local saveData = util.TableToJSON(DataTable)
                    file.Write("mana_systeme/"..v:SteamID64().."/mana_"..v:SteamID64()..".txt", saveData )

                elseif DataTable[3] > DataTable[2] then 

                    DataTable = { v:SteamID64() }
                            
                    local loadData = file.Read("mana_systeme/"..v:SteamID64().."/mana_"..v:SteamID64()..".txt")
                                
                    if loadData then 
                        DataTable = util.JSONToTable( loadData )
                    end

                    DataTable[3] = DataTable[2]

                    local saveData = util.TableToJSON(DataTable)
                    file.Write("mana_systeme/"..v:SteamID64().."/mana_"..v:SteamID64()..".txt", saveData )
                end

                DataTable = { v:SteamID64() }

                local loadData = file.Read( "mana_systeme/"..v:SteamID64().."/mana_"..v:SteamID64()..".txt")
                                
                if loadData then 
                    DataTable = util.JSONToTable( loadData )
                end
            end
        end
    end)
end)

-- Mort du joueur sans MANA -- 

hook.Add("Think", "ManaDeath", function()
    for i, v in ipairs( player.GetAll() ) do
        if v:IsPlayer() then 
            if v:Alive() then 

                DataTable = { v:SteamID64() }

                local loadData = file.Read( "mana_systeme/"..v:SteamID64().."/mana_"..v:SteamID64()..".txt")
                                
                if loadData then 
                    DataTable = util.JSONToTable( loadData )
                end

                if DataTable[3] < 1 then 
                    v:Kill()
                end

            else

                DataTable = { v:SteamID64() }
                            
                local loadData = file.Read("mana_systeme/"..v:SteamID64().."/mana_"..v:SteamID64()..".txt")
                            
                if loadData then 
                    DataTable = util.JSONToTable( loadData )
                end

                DataTable[3] = DataTable[2]

                local saveData = util.TableToJSON(DataTable)
                file.Write("mana_systeme/"..v:SteamID64().."/mana_"..v:SteamID64()..".txt", saveData )
            end
        end
    end
end)

-- Fonction baisse du mana (Weapon Attack) --

local ply = FindMetaTable("Player")

function ply:RemoveMana( n )

    if isnumber( n ) then 
        if self:IsPlayer() and self:Alive() then

            DataTable = { self:SteamID64() }
                                    
            local loadData = file.Read("mana_systeme/"..self:SteamID64().."/mana_"..self:SteamID64()..".txt")
                        
            if loadData then 
                DataTable = util.JSONToTable( loadData )
            end

            DataTable[3] = DataTable[3] - n

            local saveData = util.TableToJSON(DataTable)
            file.Write("mana_systeme/"..self:SteamID64().."/mana_"..self:SteamID64()..".txt", saveData )
        end
    end
end

-- Verif du Mana et Mana Max pour l'hud -- 

hook.Add("Think", "ManaHud", function()

    for i, v in ipairs( player.GetAll() ) do

        DataTable = { v:SteamID64() }

        local loadData = file.Read( "mana_systeme/"..v:SteamID64().."/mana_"..v:SteamID64()..".txt")
                                    
        if loadData then 
            DataTable = util.JSONToTable( loadData )
        end

        v:SetNWInt("Mana", math.Round(DataTable[3]))
        v:SetNWInt("MaxMana", math.Round(DataTable[2]))

    end
end)

---------------------------------------
