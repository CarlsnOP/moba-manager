extends Node


var inventory: Inventory = Inventory.new()
var _rubberduckies := 0
var _all_loot: Array[LootResource] = []
var _all_items: Array[ItemResource] = []

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

func get_rubberduckies() -> int:
	return _rubberduckies

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
