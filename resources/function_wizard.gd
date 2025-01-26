class_name FunctionWizard
extends Node

static func Create_loot_reward(loot_amount: int) -> Array[LootResource]:
	if loot_amount <= 0:
		var empty_array: Array[LootResource] = []
		return empty_array
		
	var eligible_loot = []
	var total_weight = 0
	var new_loot_gained: Array[LootResource] = []
	
	for loot in InventoryManager._all_loot:
		eligible_loot.append(loot)
		total_weight += loot.weight
	
	while loot_amount > 1:
		var rand_weight = randf() * total_weight
		var cumulative_weight = 0
		
		for loot in eligible_loot:
			cumulative_weight += loot.weight
			if rand_weight <= cumulative_weight:
				if loot_amount >= loot.value:
					InventoryManager.inventory.add_loot(loot, 1)
					loot_amount -= loot.value
					new_loot_gained.append(loot)
				break
	return new_loot_gained
