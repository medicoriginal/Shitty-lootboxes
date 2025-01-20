include("shared.lua")


function ENT:Draw()
    self:DrawModel() 

net.Receive("baseboxhud", function ()
    

local frame = vgui.Create( "DFrame" )
frame:SetSize( 300, 250 )
frame:SetTitle("Мусорка")
frame:Center()
frame:SetDraggable(false)
frame:MakePopup()
function frame:Paint( w, h )
    draw.RoundedBox( 8, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
end

local DermaButton = vgui.Create( "DButton", frame ) 
DermaButton:SetText( "Обыскать.." )					
DermaButton:SetPos( 25, 50 )					
DermaButton:SetSize( 250, 150 )					
function DermaButton:Paint( w, h )
    draw.RoundedBox( 8, 0, 0, w, h, Color( 0, 0, 0, 250 ) )
end
DermaButton.DoClick = function()				
    DermaButton:SetText("Обыскивается...")
	self:EmitSound( "physics/metal/metal_computer_impact_soft"..math.random(2,3)..".wav", 65 )
    timer.Simple(2, function ()
        net.Start("spawnloot")
        net.SendToServer()
frame:Remove()
self:EmitSound( "physics/metal/metal_grate_impact_hard"..math.random(1,3)..".wav", 65 )

 frame:Remove()    

  
end)
end 
end)
end
