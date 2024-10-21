class_name Inventory

var _loot_content:Array[LootResource] = []
var _item_content:Array[ItemResource] = []

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
		

#ITEM FUNCTIONS
func add_item(item: ItemResource, amount: int):
	item.quantity += amount

func remove_item(item: ItemResource, amount: int):
	item.quantity -= amount

func get_item() -> Array[ItemResource]:
	return _item_content

#
func has_all(items:Array[LootResource]) -> bool:
	var needed:Array[LootResource] = items.duplicate()
	
	for available in _loot_content:
		needed.erase(available)
	
	return needed.is_empty()
