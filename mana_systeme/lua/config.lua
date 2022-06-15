--//// Système crée par Liquid_stk#7729 \\\\--

--//// System created by Liquid_stk#7729 \\\\--

--

Mana.config.mana_start = 300                -- Nombre de MANA lors de la première connexion !
                                            -- Number of MANA during the first connection!
--

Mana.config.mana_up = 150                   -- Nombre de Mana (max) gagner en fonction de (Mana.config.mana_time_up)
                                            -- Number of Mana (max) gain based on (Mana.config.mana_time_up)

Mana.config.mana_time_up = 600              -- Temps en secondes pour gagner du mana (max) en fonction de (Mana.config.mana_up) 
                                            -- Time in seconds to gain mana (max) based on (Mana.config.mana_up)
--

Mana.config.mana_regene = 5                 -- Régéneration du mana (en %) en fonction du mana totale du joueur.
                                            -- Mana regen (in %) based on player's total mana.


Mana.config.mana_time_regene = 20           -- Régéneration en seconde du mana en fonction de (Mana.config.mana_regene)
                                            -- Mana regeneration in seconds based on (Mana.config.mana_regene)
--

Mana.config.mana_admin_command = "!mana"    -- Commande pour ouvrir le panel d'administration du MANA     
                                            -- Command to open MANA admin panel

Mana.config.mana_admin = {

    ["admin"] = true,                       -- Rang d'accès au panel d'administration du MANA   
    ["superadmin"] = true,                  -- MANA Admin Panel Access Rank
}


-- Example en Primary Attack : self.Owner:RemoveMana(300) -- Enlève 300 de Mana au joueur qui utilise l'arme.
-- Example in Primary Attack : self.Owner:RemoveMana(300) -- Removes 300 Mana from the player who uses the weapon.

-- Fonction "cl" pour get le mana max : LocalPlayer():GetNWInt("MaxMana")
-- "cl" function to get max mana: LocalPlayer():GetNWInt("MaxMana")


-- Fonction "cl" pour get le mana : LocalPlayer():GetNWInt("Mana") 
-- "cl" function to get mana: LocalPlayer():GetNWInt("Mana")
