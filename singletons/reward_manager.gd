extends Node

const BASE_LOOT_REWARD := 30
const BASE_EXP_REWARD := 50
const BASE_RUBBERDUCK_REWARD := 100
const WIN_MODIFIER := 2.0


var _mod_luck := 1.0
var _loot_gained: Array[LootResource] = []
var _exp_gained: int
var _rubberduckies_gained: int
var loot_gained_last_game: int

func on_battle_end(win: bool) -> void:
	var loot_reward = round((BASE_LOOT_REWARD * (1 + StatsManager.all_stats_multipliers["loot_multiplier"]) * _mod_luck))
	var exp_reward = round(BASE_EXP_REWARD * (1 + StatsManager.all_stats_multipliers["loot_multiplier"]))
	var rubberduckies_reward = round(BASE_RUBBERDUCK_REWARD * (1 + StatsManager.all_stats_multipliers["loot_multiplier"]))
	
	
	if win:
		loot_reward = loot_reward * WIN_MODIFIER
		exp_reward = exp_reward * WIN_MODIFIER
		create_rubberduckies(rubberduckies_reward * WIN_MODIFIER)
		_exp_gained = exp_reward
		_rubberduckies_gained = rubberduckies_reward * WIN_MODIFIER
	
	else:
		create_rubberduckies(rubberduckies_reward)
		_exp_gained = exp_reward
		_rubberduckies_gained = rubberduckies_reward
	
	loot_gained_last_game = loot_reward
	TeamManager.grant_current_team_exp(exp_reward)
	
	_loot_gained = FunctionWizard.create_loot_reward(loot_reward)
	
	_mod_luck = 1.0

func create_rubberduckies(quantity: int) -> void:
	if quantity <= 0:
		return
	
	InventoryManager._rubberduckies += quantity
	AchievementManager.the_almighty_storage_dictionary["total_rubber_duckies_earned"] += quantity
	
	SignalManager.rubberduckies_created.emit(quantity)
	SignalManager.rubberduckies_updated.emit()
