extends Node

var DEFAULT_STATS_MULTIPLIER: Dictionary = {
	#Loot Multipliers
	"rubberduck_multiplier": 0,
	"loot_multiplier": 0,
	"xp_multiplier": 0,
	
	#Hero Multiplires
	"hp_multiplier": 0,
	"hp_reg_multiplier": 0,
	"damage_multiplier": 0,
	"ap_multiplier": 0,
	"block_multiplier": 0,
	"dodge_multiplier": 0,
	"crit_multiplier": 0,
	
}

var all_stats_multipliers: Dictionary = DEFAULT_STATS_MULTIPLIER.duplicate()
var achievement_multipliers: Dictionary = DEFAULT_STATS_MULTIPLIER.duplicate()
var hero_specific_stats := []

func _ready():
	SignalManager.achievements_updated.connect(update_multipliers)
	update_hero_stats(TeamManager._all_heroes)

func update_multipliers() -> void:
	for key in all_stats_multipliers.keys():
		all_stats_multipliers[key] = 0
		
	for key in achievement_multipliers.keys():
		achievement_multipliers[key] = 0
	
	update_achievement_multipliers()
	update_all_stats_multipliers()
	update_hero_stats(TeamManager._all_heroes)


func update_achievement_multipliers() -> void:
	for child in AchievementManager.all_achievements:
		match child.ach_reward_type:
			
			child.REWARD_TYPE.RUBBERDUCKS:
				achievement_multipliers["rubberduck_multiplier"] += child.ach_reward_growth * child.ach_accepted_rewards
			
			child.REWARD_TYPE.XP:
				achievement_multipliers["xp_multiplier"] += child.ach_reward_growth * child.ach_accepted_rewards
			
			child.REWARD_TYPE.LOOT:
				achievement_multipliers["loot_multiplier"] += child.ach_reward_growth * child.ach_accepted_rewards

			#Hero specific
			child.REWARD_TYPE.HP:
				achievement_multipliers["hp_multiplier"] += child.ach_reward_growth * child.ach_accepted_rewards
				
			child.REWARD_TYPE.HPREG:
				achievement_multipliers["hp_reg_multiplier"] += child.ach_reward_growth * child.ach_accepted_rewards
				
			child.REWARD_TYPE.AD:
				achievement_multipliers["damage_multiplier"] += child.ach_reward_growth * child.ach_accepted_rewards
			
			child.REWARD_TYPE.AP:
				achievement_multipliers["ap_multiplier"] += child.ach_reward_growth * child.ach_accepted_rewards
			
			child.REWARD_TYPE.BLOCK:
				achievement_multipliers["block_multiplier"] += child.ach_reward_growth * child.ach_accepted_rewards
			
			child.REWARD_TYPE.DODGE:
				achievement_multipliers["dodge_multiplier"] += child.ach_reward_growth * child.ach_accepted_rewards
			
			child.REWARD_TYPE.CRIT:
				achievement_multipliers["crit_multiplier"] += child.ach_reward_growth * child.ach_accepted_rewards

func update_all_stats_multipliers() -> void:
	for key in all_stats_multipliers.keys():
		if key in achievement_multipliers:
			all_stats_multipliers[key] += achievement_multipliers[key]

func update_hero_stats(heroes: Array) -> void:
	hero_specific_stats.clear()

	for hero in heroes:
		if hero is HeroResource:
			var hero_stats_entry: Dictionary = {
				"hero": hero,
				"health": (hero.health + (hero.lvl * hero.extra_hp)) * (1 + all_stats_multipliers["hp_multiplier"] / 100),
				"health_reg": (hero.health_regen * (1 + all_stats_multipliers["hp_multiplier"] / 100)),
				"damage": (hero.attack_damage + (hero.lvl * hero.extra_ad)) * (1 + all_stats_multipliers["hp_multiplier"] / 100),
				"ability_power": (hero.ability_power + (hero.lvl * hero.extra_ap)) * (1 + all_stats_multipliers["hp_multiplier"] / 100),
				"block": (hero.block * (1 + all_stats_multipliers["block_multiplier"])) * 100,
				"dodge": (hero.block * (1 + all_stats_multipliers["block_multiplier"])) * 100,
				"crit": (hero.block * (1 + all_stats_multipliers["block_multiplier"])) * 100,
			}
			
			if hero.equipped_equipment != null:
					hero_stats_entry["health"] *= hero.equipped_equipment.equipment_hp
					hero_stats_entry["health_reg"] *= hero.equipped_equipment.equipment_hp_regen
					hero_stats_entry["damage"] *= hero.equipped_equipment.equipment_ad
					hero_stats_entry["ability_power"] *= hero.equipped_equipment.equipment_ap
					hero_stats_entry["block"] += hero.equipped_equipment.equipment_block
					hero_stats_entry["dodge"] += hero.equipped_equipment.equipment_dodge
					hero_stats_entry["crit"] += hero.equipped_equipment.equipment_crit
			
			hero_specific_stats.append(hero_stats_entry)
