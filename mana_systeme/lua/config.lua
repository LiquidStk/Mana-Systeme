--//// Système crée par Liquid_stk#7729 \\\\--


--

Mana.config.mana_start = 300                -- Nombre de MANA lors de la première connexion !

--

Mana.config.mana_up = 150                   -- Nombre de Mana gagner en fonction de (Mana.config.mana_time_up)
Mana.config.mana_time_up = 600              -- Temps en secondes pour gagner du mana en fonction de (Mana.config.mana_up) 

--

Mana.config.mana_regene = 5                 -- Régéneration du mana (en %) en fonction du mana totale du joueur.
Mana.config.mana_time_regene = 20           -- Régéneration en seconde du mana en fonction de (Mana.config.mana_regene)

--

Mana.config.mana_admin_command = "!mana"    -- Commande pour ouvrir le panel d'administration du MANA     

Mana.config.mana_admin = {

    ["admin"] = true,                       -- Rang d'accès au panel d'administration du MANA   
    ["superadmin"] = true,
}


-- Example en Primary Attack : self.Owner:RemoveMana(300) -- Enlève 300 de Mana au joueur qui utilise l'arme.

-- Fonction "cl" pour get le mana max : LocalPlayer():GetNWInt("MaxMana") 
-- Fonction "cl" pour get le mana : LocalPlayer():GetNWInt("Mana") 