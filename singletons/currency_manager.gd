extends Node


var inventory: Inventory = Inventory.new()
var _rubberduckies := 0
var _all_loot: Array[LootResource] = []
var _all_items: Array[ItemResource] = []
var quantity_of_items: Array[int] = []
var quantity_of_loot: Array[int] = []

func _ready():
	for file in DirAccess.get_files_at("res://resources/items/loot/items/"):
		var resource_file = "res://resources/items/loot/items/" + file
		var loot: LootResource = load(resource_file) as LootResource
		_all_loot.append(loot)
	
	for file in DirAccess.get_files_at("res://resources/items/hero_items/items/"):
		var resource_file = "res://resources/items/hero_items/items/" + file
		var item: ItemResource = load(resource_file) as ItemResource
		_all_items.append(item)

func on_battle_end(win: bool) -> void:
	if win:
		create_rubberduckies(100)
		inventory.add_loot(_all_loot[0], 2)
	else:
		create_rubberduckies(10)
		inventory.add_loot(_all_loot[5], 3)

func create_rubberduckies(quantity: int) -> void:
	if quantity <= 0:
		return
	
	_rubberduckies += quantity
	
	SignalManager.rubberduckies_created.emit(quantity)
	SignalManager.rubberduckies_updated.emit()

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
