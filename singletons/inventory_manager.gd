extends Node

#Contains all the users loot and Rubberduckies

var inventory: Inventory = Inventory.new()
var _rubberduckies := 0
var _all_loot: Array[LootResource] = []
var _all_items: Array[ItemResource] = []
var quantity_of_items: Array[int] = []
var quantity_of_loot: Array[int] = []

func _ready():
	for file in DirAccess.get_files_at("res://resources/items/drops/"):
		var resource_file = "res://resources/items/drops/" + file
		var loot: LootResource = load(resource_file) as LootResource
		_all_loot.append(loot)
	
	for file in DirAccess.get_files_at("res://resources/items/equipment/"):
		var resource_file = "res://resources/items/equipment/" + file
		var item: ItemResource = load(resource_file) as ItemResource
		_all_items.append(item)

func can_spend(quantity: int) -> bool:
	if quantity < 0:
		return false
	
	if quantity > _rubberduckies:
		return false
	
	return true

func spend_rubberduckies(quantity: int) -> Error:
	if quantity < 0:
		return Error.FAILED
	
	if quantity > _rubberduckies:
		return Error.FAILED
	
	_rubberduckies -= quantity
	
	SignalManager.rubberduckies_spent.emit(quantity)
	SignalManager.rubberduckies_updated.emit()
	
	return Error.OK

func get_rubberduckies() -> int:
	return _rubberduckies

#FOR SAVING AND LOADING
func get_items_quantity() -> Array[int]:
	quantity_of_items.clear()
	
	for item in _all_items:
		quantity_of_items.append(item.quantity)
	return quantity_of_items

func set_items_quantity(items_quantity: Array[int]):
	if items_quantity.size() != _all_items.size():
		return
	
	for item in range(_all_items.size()):
		_all_items[item].quantity = items_quantity[item]
		
func get_loot_quantity() -> Array[int]:
	quantity_of_loot.clear()
	
	for loot in _all_loot:
		quantity_of_loot.append(loot.quantity)
	return quantity_of_loot

func set_loot_quantity(loot_quantity: Array[int]):
	if loot_quantity.size() != _all_loot.size():
		return
	
	for loot in range(_all_loot.size()):
		_all_loot[loot].quantity = loot_quantity[loot]

func get_loot() -> Array[LootResource]:
	return _all_loot
