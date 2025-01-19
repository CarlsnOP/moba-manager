extends Node

const STAGE_MULTIPLIER_STAT_ADJUSTMENT := 0.5

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
var enemy_hero_specific_stats := []
var stage_manager_ref: StageManager
var stage_multiplier: float

func _ready():
	SignalManager.achievements_updated.connect(update_multipliers)
	stage_manager_ref = get_tree().get_first_node_in_group("stage_manager")
	update_multipliers()

func update_multipliers() -> void:
	for key in all_stats_multipliers.keys():
		all_stats_multipliers[key] = 0
		
	for key in achievement_multipliers.keys():
		achievement_multipliers[key] = 0
	
	stage_multiplier = stage_manager_ref.get_stage_modifer()
	
	update_achievement_multipliers()
	update_all_stats_multipliers()
	update_hero_stats(TeamManager._all_heroes)
	update_enemy_hero_stats(TeamManager._all_enemy_heroes)
	

func update_achievement_multipliers() -> void:
	for child in AchievementManager.all_achievements:
		match child.ach_reward_type:
			
			child.REWARD_TYPE.RUBBERDUCKS:
				achievement_multipliers["rubberduck_multiplier"] += float(child.ach_reward_growth * child.ach_accepted_rewards) / 100
			
			child.REWARD_TYPE.XP:
				achievement_multipliers["xp_multiplier"] += float(child.ach_reward_growth * child.ach_accepted_rewards) / 100
			
			child.REWARD_TYPE.LOOT:
				achievement_multipliers["loot_multiplier"] += float(child.ach_reward_growth * child.ach_accepted_rewards) / 100

			#Hero specific
			child.REWARD_TYPE.HP:
				achievement_multipliers["hp_multiplier"] += float(child.ach_reward_growth * child.ach_accepted_rewards) / 100
				
			child.REWARD_TYPE.HPREG:
				achievement_multipliers["hp_reg_multiplier"] += float(child.ach_reward_growth * child.ach_accepted_rewards) / 100
				
			child.REWARD_TYPE.AD:
				achievement_multipliers["damage_multiplier"] += float(child.ach_reward_growth * child.ach_accepted_rewards) / 100
			
			child.REWARD_TYPE.AP:
				achievement_multipliers["ap_multiplier"] += float(child.ach_reward_growth * child.ach_accepted_rewards) / 100
			
			child.REWARD_TYPE.BLOCK:
				achievement_multipliers["block_multiplier"] += float(child.ach_reward_growth * child.ach_accepted_rewards) / 100
			
			child.REWARD_TYPE.DODGE:
				achievement_multipliers["dodge_multiplier"] += float(child.ach_reward_growth * child.ach_accepted_rewards) / 100
			
			child.REWARD_TYPE.CRIT:
				achievement_multipliers["crit_multiplier"] += float(child.ach_reward_growth * child.ach_accepted_rewards)  / 100

func update_all_stats_multipliers() -> void:
	for key in all_stats_multipliers.keys():
		if key in achievement_multipliers:
			all_stats_multipliers[key] += achievement_multipliers[key]
	
	all_stats_multipliers["rubberduck_multiplier"] += stage_multiplier
	all_stats_multipliers["xp_multiplier"] += stage_multiplier
	all_stats_multipliers["loot_multiplier"] += stage_multiplier

func update_hero_stats(heroes: Array) -> void:
	hero_specific_stats.clear()

	for hero in heroes:
		if hero is HeroResource:
			var hero_stats_entry: Dictionary = {
				"hero": hero,
				"health": (hero.health + (hero.lvl * hero.extra_hp)) * (1 + all_stats_multipliers["hp_multiplier"]),
				"health_reg": (hero.health_regen * (1 + all_stats_multipliers["hp_multiplier"])),
				"damage": (hero.attack_damage + (hero.lvl * hero.extra_ad)) * (1 + all_stats_multipliers["hp_multiplier"]),
				"ability_power": (hero.ability_power + (hero.lvl * hero.extra_ap)) * (1 + all_stats_multipliers["hp_multiplier"]),
				"block": hero.block + all_stats_multipliers["block_multiplier"],
				"dodge": hero.dodge + all_stats_multipliers["dodge_multiplier"],
				"crit": hero.crit + all_stats_multipliers["crit_multiplier"],
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
			
func update_enemy_hero_stats(heroes: Array) -> void:
	enemy_hero_specific_stats.clear()

	for hero in heroes:
		if hero is HeroResource:
			var hero_stats_entry: Dictionary = {
				"hero": hero,
				"health": hero.health * (STAGE_MULTIPLIER_STAT_ADJUSTMENT + stage_multiplier),
				"health_reg": hero.health_regen,
				"damage": hero.attack_damage * (STAGE_MULTIPLIER_STAT_ADJUSTMENT + stage_multiplier),
				"ability_power": hero.ability_power,
				"block": hero.block,
				"dodge": hero.dodge,
				"crit": hero.crit,
				}
				
			enemy_hero_specific_stats.append(hero_stats_entry)
