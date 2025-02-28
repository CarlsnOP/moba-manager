extends VBoxContainer

@export var slot_scene: PackedScene

@onready var offensive_vb = %OffensiveVB
@onready var defensive_vb = %DefensiveVB
@onready var utility_vb = %UtilityVB
@onready var economy_vb = %EconomyVB


func display(upgrades: Array[ShopUpgradeResource]):
	#for child in get_children():
		#child.queue_free()
	
	for upgrade in upgrades:
		var slot = slot_scene.instantiate()
		
		match upgrade.type:
			
			upgrade.TYPE.OFFENSIVE:
				offensive_vb.add_child(slot)
				slot.display(upgrade)
				
			upgrade.TYPE.DEFENSIVE:
				defensive_vb.add_child(slot)
				slot.display(upgrade)
			
			upgrade.TYPE.UTILITY:
				utility_vb.add_child(slot)
				slot.display(upgrade)
				
			upgrade.TYPE.ECONOMY:
				economy_vb.add_child(slot)
				slot.display(upgrade)
