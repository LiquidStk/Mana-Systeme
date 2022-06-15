net.Receive("OpenPanelMana", function()
        
    if  Mana.config.mana_admin[LocalPlayer():GetUserGroup()] then 
        if LocalPlayer():IsPlayer() and LocalPlayer():Alive() then 

            Mana.panel_admin = vgui.Create("DFrame")
            Mana.panel_admin:SetSize(W(800), H(800))
            Mana.panel_admin:Center()
            Mana.panel_admin:SetDraggable(false)
            Mana.panel_admin:ShowCloseButton(false)
            Mana.panel_admin:MakePopup()
            Mana.panel_admin:SetTitle("")
            function Mana.panel_admin:Paint(w, h)
                draw.RoundedBox(8, 0, 0, w, h, Color(45, 45, 45, 255))
                draw.SimpleText("Mana - Administration", "font_LiquidMana2", W(400), H(50), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end

            Mana.close_button = vgui.Create("DImageButton", Mana.panel_admin)
            Mana.close_button:SetSize(W(42), H(42))
            Mana.close_button:SetPos(W(753), H(5))
            Mana.close_button:SetMaterial(Mana.Materials.close_button)
            function Mana.close_button:DoClick()
                Mana.panel_admin:Remove()
            end

            Mana.panel_player = vgui.Create("DPanel", Mana.panel_admin)
            Mana.panel_player:SetSize(W(200), H(650))
            Mana.panel_player:SetPos(W(25), H(110))
            function Mana.panel_player:Paint(w, h)
                draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 100))
            end
                
            Mana.scrollplayer = vgui.Create( "DScrollPanel", Mana.panel_admin )
            Mana.scrollplayer:SetTall( H(600) )
            Mana.scrollplayer:SetWide( W(180) )
            Mana.scrollplayer:SetPos(W(35), H(120))

            local bar = Mana.scrollplayer:GetVBar()

            function bar:Paint(w,h)
                draw.RoundedBox(0,0,0,w,h,Color(0,0,0,0))
            end 
            function bar.btnUp:Paint(w,h)
                draw.RoundedBox(0,0,0,w,h,Color(0,0,0,0))
            end 
            function bar.btnDown:Paint(w,h)
                draw.RoundedBox(0,0,0,w,h,Color(0,0,0,0))
            end 
            function bar.btnGrip:Paint(w,h)
                draw.RoundedBox(0,0,0,w,h,Color(0,0,0,0))
            end 

            for k, v in pairs(player.GetAll()) do

                Mana.player_select = vgui.Create("DPanel", Mana.scrollplayer)
                Mana.player_select:SetTall(H(35))			
                Mana.player_select:SetWide(W(180))
                Mana.player_select:SetPos(W(0), H(25))
                Mana.player_select:Dock(TOP)
                function Mana.player_select:Paint(w, h)
                    draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 255))
                    draw.RoundedBox(0,0,0, Mana.player_select:GetWide(), H(3), Color(255, 255, 255, 225))
                    draw.SimpleText(v:Name(), "font_LiquidMana", W(90), H(18), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end

                Mana.button_player = vgui.Create("DButton", Mana.player_select)
                Mana.button_player:SetSize(Mana.player_select:GetWide(), Mana.player_select:GetTall())
                Mana.button_player:SetPos(0,0)
                Mana.button_player:SetText("")
                function Mana.button_player:Paint(w, h)
                    draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255,0))
                end
                function Mana.button_player:DoClick()
                    
                    if IsValid(Mana.panel_choice) then Mana.panel_choice:Remove() end

                    Mana.panel_choice = vgui.Create("DPanel", Mana.panel_admin)
                    Mana.panel_choice:SetSize(W(400), H(500))
                    Mana.panel_choice:SetPos(W(300), H(200))
                    function Mana.panel_choice:Paint(w, h)
                        draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 100))
                        draw.SimpleText("Action - "..v:Name(), "font_LiquidMana1", W(200), H(25), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        draw.SimpleText("-- Changer le Mana Max --", "font_LiquidMana", W(200), H(250), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        draw.SimpleText("Mana - "..v:GetNWInt("Mana"), "font_LiquidMana", W(80), H(100), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        draw.SimpleText("Max Mana - "..v:GetNWInt("MaxMana"), "font_LiquidMana", W(105), H(150), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    end

                    Mana.DTextEntry = vgui.Create("DTextEntry", Mana.panel_choice)
                    Mana.DTextEntry:SetSize(W(200), H(25))
                    Mana.DTextEntry:SetPos(W(100), H(300))
                    Mana.DTextEntry:SetMultiline(false)
                    Mana.DTextEntry:SetEditable(true)
                    Mana.DTextEntry:SetPaintBackground(true)
                    Mana.DTextEntry:SetFont("font_LiquidMana")
                    Mana.DTextEntry:SetNumeric(true)
                    Mana.DTextEntry:SetTextColor(Color(255,255,255,255))
                    
                    function Mana.DTextEntry:OnChange() 
                        LocalPlayer():EmitSound(Mana.Sound.typing_sound, 35)
                    end
    
                    function Mana.DTextEntry:Paint(w, h)
                        surface.SetDrawColor(0, 0, 0, 100)
                        surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
                        self:DrawTextEntryText(Color(255, 255, 255), Color(30, 130, 255), Color(255, 255, 255))
                    end

                    Mana.button_valid = vgui.Create("DButton", Mana.panel_choice)
                    Mana.button_valid:SetSize(W(200), H(50))
                    Mana.button_valid:SetPos(W(100), H(350))
                    Mana.button_valid:SetText("")
                    function Mana.button_valid:Paint(w, h)
                        if Mana.button_valid:IsHovered() then
                            draw.RoundedBox(8,0,0,w,h,Color(85,85,85,255))
                            draw.SimpleText("Changer le Mana Max par :", "font_LiquidMana3", W(100), H(15), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                            draw.SimpleText(Mana.DTextEntry:GetValue(), "font_LiquidMana4", W(100), H(35), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        else 
                            draw.RoundedBox(8,0,0,w,h,Color(50,50,50,255))
                            draw.SimpleText("Changer le Mana Max par :", "font_LiquidMana3", W(100), H(15), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                            draw.SimpleText(Mana.DTextEntry:GetValue(), "font_LiquidMana4", W(100), H(35), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        end
                    end
                    function Mana.button_valid:DoClick()

                        local value = tonumber(Mana.DTextEntry:GetValue())

                        if isnumber(value) then 
                            if LocalPlayer():IsPlayer() and Mana.config.mana_admin[LocalPlayer():GetUserGroup()] then

                                net.Start("InfoManaSet")
                                net.WriteEntity(v)
                                net.WriteEntity(LocalPlayer())
                                net.WriteInt(value, 32)
                                net.SendToServer()

                                Mana.panel_choice:Remove()
                            end
                        end
                    end

                    Mana.button_reset = vgui.Create("DButton", Mana.panel_choice)
                    Mana.button_reset:SetSize(W(200), H(50))
                    Mana.button_reset:SetPos(W(100), H(425))
                    Mana.button_reset:SetText("")
                    function Mana.button_reset:Paint(w, h)
                        if Mana.button_reset:IsHovered() then
                            draw.RoundedBox(8,0,0,w,h,Color(85,85,85,255))
                            draw.SimpleText("RESET les stats de :", "font_LiquidMana3", W(100), H(15), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                            draw.SimpleText(v:Name(), "font_LiquidMana4", W(100), H(35), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        else 
                            draw.RoundedBox(8,0,0,w,h,Color(50,50,50,255))
                            draw.SimpleText("RESET les stats de :", "font_LiquidMana3", W(100), H(15), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                            draw.SimpleText(v:Name(), "font_LiquidMana4", W(100), H(35), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        end
                    end
                    function Mana.button_reset:DoClick()

                        if LocalPlayer():IsPlayer() and Mana.config.mana_admin[LocalPlayer():GetUserGroup()] then 

                            net.Start("InfoManaReset")
                            net.WriteEntity(v)
                            net.WriteEntity(LocalPlayer())
                            net.SendToServer()

                            Mana.panel_choice:Remove()
                        end
                    end
                end
            end
        end 
    end
end)