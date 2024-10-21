class_name Inventory

var _loot_content:Array[LootResource] = []
var _item_content:Array[ItemResource] = []

#LOOT FUNCTIONS
func add_loot(loot: LootResource):
	_loot_content.append(loot)

func remove_loot(loot: LootResource):
	_loot_content.erase(loot)

func get_loot() -> Array[LootResource]:
	return _loot_content

#ITEM FUNCTIONS
func add_item(item: ItemResource):
	_item_content.append(item)

func remove_item(item: ItemResource):
	_item_content.erase(item)

func get_item() -> Array[ItemResource]:
	return _item_content

#
func has_all(items:Array[LootResource]) -> bool:
	var needed:Array[LootResource] = items.duplicate()
	
	for available in _loot_content:
		needed.erase(available)
	
	return needed.is_empty()
