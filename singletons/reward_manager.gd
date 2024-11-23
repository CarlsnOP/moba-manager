extends Node

const BASE_LOOT_REWARD := 50
const BASE_EXP_REWARD := 50
const BASE_RUBBERDUCK_REWARD := 50
const WIN_MODIFIER := 2.0

var _mod_rank := 1.0
var _mod_luck := 1.0

func on_battle_end(win: bool, enemy_modifier: float) -> void:
	var loot_reward = round((BASE_LOOT_REWARD * (enemy_modifier + _mod_rank)) * _mod_luck)
	var exp_reward = round(BASE_EXP_REWARD * (enemy_modifier + _mod_rank))
	var eligible_loot = []
	var total_weight = 0
	
	if win:
		loot_reward = loot_reward * WIN_MODIFIER
		exp_reward = exp_reward * WIN_MODIFIER
		create_rubberduckies(round(BASE_RUBBERDUCK_REWARD * (enemy_modifier + _mod_rank) * WIN_MODIFIER))
	
	else:
		create_rubberduckies(round(BASE_RUBBERDUCK_REWARD * (enemy_modifier + _mod_rank)))
	
	TeamManager.grant_current_team_exp(exp_reward)
	
	for loot in InventoryManager._all_loot:
		eligible_loot.append(loot)
		total_weight += loot.weight
	
	while loot_reward > 1:
		var rand_weight = randf() * total_weight
		var cumulative_weight = 0
		
		for loot in eligible_loot:
			cumulative_weight += loot.weight
			if rand_weight <= cumulative_weight:
				if loot_reward >= loot.value:
					InventoryManager.inventory.add_loot(loot, 1)
					loot_reward -= loot.value
				break
				
	_mod_luck = 1.0
	
func create_rubberduckies(quantity: int) -> void:
	if quantity <= 0:
		return
	
	InventoryManager._rubberduckies += quantity
	
	SignalManager.rubberduckies_created.emit(quantity)
	SignalManager.rubberduckies_updated.emit()
