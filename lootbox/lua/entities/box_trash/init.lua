local loottable = {
    "models/props_junk/PopCan01a.mdl",
    "models/props_junk/CinderBlock01a.mdl",
"models/props_junk/plasticbucket001a.mdl",
"models/props_junk/metalgascan.mdl",
"models/Gibs/HGIBS.mdl",
"models/props_lab/clipboard.mdl"
}

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("baseboxhud")
util.AddNetworkString("spawnloot")
function ENT:Initialize()
local modelofent = math.random(1,3)
if modelofent == 1 then
    self:SetModel( "models/props_junk/TrashBin01a.mdl" )
else
    self:SetModel( "models/props_trainstation/trashcan_indoor001a.mdl" )
  --  self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS ) 
    self:SetSolid( SOLID_VPHYSICS )
    local phys = self:GetPhysicsObject() 
    if phys:IsValid() then
        phys:Wake()
    end
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
    local objectl = ents.Create("prop_physics")
    objectl:SetModel(loot)
    objectl:SetPos(self:GetPos())
    objectl:Spawn()
    objectl:Activate()
self:Remove()
end) end
end
