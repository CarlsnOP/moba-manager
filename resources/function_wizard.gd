class_name FunctionWizard
extends Node

#Used to create loot
static func create_loot_reward(loot_amount: int) -> Array[LootResource]:
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

#For setting up a string with a heroes stats
static func setup_stats_string(hero: HeroResource) -> String:
	var temp_stats: String
	
	for h in StatsManager.hero_specific_stats:
		if h["hero"] == hero:
			temp_stats = "Max Health: " + str(h["health"]) + "\n"
			temp_stats += "Health regeneration: " + str(h["health_reg"]) + "\n"
			temp_stats += "Damage: " + str(h["damage"]) + "\n"
			temp_stats += "Ability power: " + str(h["ability_power"]) + "\n"
			temp_stats += "Block change: " + str(h["block"] * 100) + "%\n"
			temp_stats += "Dodge chance: " + str(h["dodge"] * 100) + "%\n"
			temp_stats += "Critical chance: " + str(h["crit"] * 100) + "%\n"
	
	return temp_stats


#Sort items by name and rarity
static func sort_rarity(inv) -> void:
	var sorted_nodes = inv.get_children()
	
	sorted_nodes.sort_custom(sort_by_rarity_and_name)
	
	for node in inv.get_children():
		inv.remove_child(node)
	
	for node in sorted_nodes:
		inv.add_child(node)

static func sort_by_rarity_and_name(a: Node, b: Node) -> bool:
	if a["_rarity"] == b["_rarity"]:
		if a["_name"] < b["_name"]:
			return true
			
	elif a["_rarity"] < b["_rarity"]:
		return true
	
	return false

static func apply_rarity_changes(res: Resource) -> Color:
	match res.rarity:
			EquipmentResource.RARITY.COMMON:
				return DataStorage.COLOR_COMMON
			EquipmentResource.RARITY.UNCOMMON:
				return DataStorage.COLOR_UNCOMMON
			EquipmentResource.RARITY.RARE:
				return DataStorage.COLOR_RARE
			EquipmentResource.RARITY.EPIC:
				return DataStorage.COLOR_EPIC
			EquipmentResource.RARITY.LEGENDARY:
				return DataStorage.COLOR_LEGENDARY
	return DataStorage.COLOR_COMMON

static func price_by_rarity(res: Resource) -> int:
	match res.rarity:
			EquipmentResource.RARITY.COMMON:
				return DataStorage.COMMON_PRICE
			EquipmentResource.RARITY.UNCOMMON:
				return DataStorage.UNCOMMON_PRICE
			EquipmentResource.RARITY.RARE:
				return DataStorage.RARE_PRICE
			EquipmentResource.RARITY.EPIC:
				return DataStorage.EPIC_PRICE
			EquipmentResource.RARITY.LEGENDARY:
				return DataStorage.LEGENDARY_PRICE
	return 0
