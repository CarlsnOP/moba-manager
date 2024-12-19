class_name Inventory

var _loot_content:Array[LootResource] = []
var _equipment_content: Array[EquipmentResource] = []

#LOOT FUNCTIONS
func add_loot(loot: LootResource, amount: int):
	loot.quantity += amount

func remove_loot(loot: LootResource, amount: int):
	loot.quantity -= amount

func get_loot() -> Array[LootResource]:
	return _loot_content

func check_loot_contents(loot: LootResource) -> bool:
	if _loot_content.has(loot):
		return true
	else:
		return false
		

#EQUIPMENT FUNCTIONS
func add_equipment(equipment: EquipmentResource, amount: int):
	equipment.quantity += amount

func remove_equipment(equipment: EquipmentResource, amount: int):
	equipment.quantity -= amount

func get_equipment() -> Array[EquipmentResource]:
	return _equipment_content

#
func has_all(loot: Array[LootResource]) -> bool:
	var needed: Array[LootResource] = loot.duplicate()
	
	for available in _loot_content:
		needed.erase(available)
	
	return needed.is_empty()
