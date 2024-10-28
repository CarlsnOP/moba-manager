extends Node

const BASE_LOOT_REWARD := 50
const BASE_RUBBERDUCK_REWARD := 50
const WIN_MODIFIER := 2.0

var _mod_enemy_diff := 1.0
var _mod_rank := 1.0

func on_battle_end(win: bool) -> void:
	var loot_reward = round(BASE_LOOT_REWARD * (_mod_enemy_diff + _mod_rank))
	var eligible_loot = []
	var total_weight = 0
	
	if win:
		loot_reward = loot_reward * WIN_MODIFIER
		create_rubberduckies(round(BASE_RUBBERDUCK_REWARD * (_mod_enemy_diff + _mod_rank) * WIN_MODIFIER))
	
	else:
		create_rubberduckies(round(BASE_RUBBERDUCK_REWARD * (_mod_enemy_diff + _mod_rank)))
	
	for loot in InventoryManager._all_loot:
		eligible_loot.append(loot)
		total_weight += loot.weight
	
	while loot_reward > 1:
		var rand_weight = randf() * total_weight
		var cumulative_weight = 0
		#var possible_loot = eligible_loot[randi() % eligible_loot.size()]
		
		for loot in eligible_loot:
			cumulative_weight += loot.weight
			if rand_weight <= cumulative_weight:
				if loot_reward >= loot.value:
					InventoryManager.inventory.add_loot(loot, 1)
					loot_reward -= loot.value
				break
		
		#if loot_reward >= possible_loot.value:
			#InventoryManager.inventory.add_loot(possible_loot, 1)
			#loot_reward -= possible_loot.value


func create_rubberduckies(quantity: int) -> void:
	if quantity <= 0:
		return
	
	InventoryManager._rubberduckies += quantity
	
	SignalManager.rubberduckies_created.emit(quantity)
	SignalManager.rubberduckies_updated.emit()
