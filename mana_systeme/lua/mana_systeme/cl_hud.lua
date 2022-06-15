hook.Add( "HUDPaint", "Mana:HUD", function()

    local GetManaClamp = LocalPlayer():GetNWInt("Mana") * 100 / LocalPlayer():GetNWInt("MaxMana")

    draw.RoundedBox(8, W(1600), H(1035), W(300), H(25), Color(0, 0, 0, 200))
    draw.RoundedBox(8, W(1600), H(1035), W(GetManaClamp*3), H(25), Color(60, 165, 240, 255))
    draw.SimpleText(LocalPlayer():GetNWInt("Mana").." / "..LocalPlayer():GetNWInt("MaxMana"), "font_LiquidMana", W(1750), H(1047.5), Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

end)


