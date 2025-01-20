local loottable = {
    "weapon_crowbar",
    "weapon_pistol",
}

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("baseboxhud")
util.AddNetworkString("spawnloot")
function ENT:Initialize()
    self:SetModel( "models/props/CS_militia/footlocker01_closed.mdl" )
  --  self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS ) 
    self:SetSolid( SOLID_VPHYSICS )
    local phys = self:GetPhysicsObject() 
    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use( activator )

    self:SetUseType( SIMPLE_USE )
	if ( activator:IsPlayer() ) then 
        self:EmitSound( "physics/metal/metal_computer_impact_soft"..math.random(1,3)..".wav", 65 )
		net.Start("baseboxhud")
        net.Send( activator )
net.Receive("spawnloot", function ()
    
    local loot = loottable[math.random(1, #loottable)]
    local objectl = ents.Create(loot)
    objectl:SetModel(loot)
    objectl:SetPos(self:GetPos())
    objectl:Spawn()
    objectl:Activate()
self:Remove()
end) end
end
