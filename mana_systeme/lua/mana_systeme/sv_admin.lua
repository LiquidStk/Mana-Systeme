util.AddNetworkString("OpenPanelMana")
util.AddNetworkString("InfoManaSet")
util.AddNetworkString("InfoManaReset")

hook.Add( "PlayerSay", "Mana:Admin", function( ply, text, len )
    if ( string.lower( text ) == Mana.config.mana_admin_command ) then
        if ply:IsPlayer() and Mana.config.mana_admin[ply:GetUserGroup()] then
            net.Start("OpenPanelMana")
            net.Send(ply)
        end
    return""
    end
end)

net.Receive("InfoManaSet", function()

    local ply = net.ReadEntity()
    local sender = net.ReadEntity()
    local value = net.ReadInt(32)

    if Mana.config.mana_admin[sender:GetUserGroup()] then 

        DarkRP.notify(sender, 0, 10, "Vous avez mis le mana max de ".. ply:Name().." à "..value.." ! ")
        DarkRP.notify(ply, 0, 10, "Votre Mana a était mis à jour, votre mana max est à : "..value.." ! ")

        DataTable = { ply:SteamID64() }
                                        
        local loadData = file.Read("mana_systeme/"..ply:SteamID64().."/mana_"..ply:SteamID64()..".txt")
                            
        if loadData then 
            DataTable = util.JSONToTable( loadData )
        end

        DataTable[2] = value
        DataTable[3] = DataTable[2]

        local saveData = util.TableToJSON(DataTable)
        file.Write("mana_systeme/"..ply:SteamID64().."/mana_"..ply:SteamID64()..".txt", saveData )
    
    end
end)

net.Receive("InfoManaReset", function()

    local ply = net.ReadEntity()
    local sender = net.ReadEntity()

    if Mana.config.mana_admin[sender:GetUserGroup()] then 

        DarkRP.notify(sender, 0, 10, "Vous avez reset les statistiques du mana de ".. ply:Name().." ! ")
        DarkRP.notify(ply, 0, 10, "Vos statistiques de mana ont été reset ! ")

        DataTable = { ply:SteamID64() }
                                        
        local loadData = file.Read("mana_systeme/"..ply:SteamID64().."/mana_"..ply:SteamID64()..".txt")
                            
        if loadData then 
            DataTable = util.JSONToTable( loadData )
        end

        DataTable[2] = Mana.config.mana_start
        DataTable[3] = DataTable[2]

        local saveData = util.TableToJSON(DataTable)
        file.Write("mana_systeme/"..ply:SteamID64().."/mana_"..ply:SteamID64()..".txt", saveData )

    end
end)

