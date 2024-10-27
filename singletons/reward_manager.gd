extends Node


func on_battle_end(win: bool) -> void:
	if win:
		create_rubberduckies(100)
		InventoryManager.inventory.add_loot(InventoryManager._all_loot[0], 2)
	else:
		create_rubberduckies(10)
		InventoryManager.inventory.add_loot(InventoryManager._all_loot[5], 3)

func create_rubberduckies(quantity: int) -> void:
	if quantity <= 0:
		return
	
	InventoryManager._rubberduckies += quantity
	
	SignalManager.rubberduckies_created.emit(quantity)
	SignalManager.rubberduckies_updated.emit()
