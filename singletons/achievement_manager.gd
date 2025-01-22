extends Node

var the_almighty_storage_dictionary: Dictionary = {
	#Battle sim specific
	"wins": 0,
	"losses": 0,
	"wins_without_deaths": 0,
	
	#Hero Specific
	"highest_level_hero": 0,
	"hero_levels": [],
	"hero_total_levels": 0,
	"hero_stats": [],
	"enemy_hero_stats": [],
	
	#Item specific
	"unique_loot": [],
	"equipment_crafted": 0,
	"unique_equipment_crafted": [],
	
	#Economy specific
	"total_rubber_duckies_earned": 0,
	
	#Achievement Specific
	"achievement_stats": [],
}

var all_achievements: Array[AchievementResource] = []
var ach_index := 0
var achievement_node := Node.new()


func _ready():
	for file in DirAccess.get_files_at("res://resources/achievements/resources/"):
		var resource_file = "res://resources/achievements/resources/" + file
		var achievement: AchievementResource = load(resource_file) as AchievementResource
		achievement.ach_index += ach_index
		ach_index += 1
		all_achievements.append(achievement)
	SignalManager.on_equipment_crafted.connect(on_equipment_crafted)
	SignalManager.on_battle_end.connect(on_battle_end)
	
	check_and_add_achievement_stats()
	check_if_new_heroes()
	
	await get_tree().physics_frame

	update_achievements()
	
func update_achievement_stats(achievement: AchievementResource) -> void:
	for achievement_stat in the_almighty_storage_dictionary["achievement_stats"]:
		if achievement_stat["res"] == achievement:
			achievement_stat["accepted_rewards"] += 1
			update_achievements()


func update_achievements() -> void:
	for achievement in all_achievements:
		if achievement.ach_script != null:
			achievement.ach_script.update_achievement(achievement)
			
		for achievement_stat in the_almighty_storage_dictionary["achievement_stats"]:
			if achievement_stat["res"] == achievement:
				achievement.ach_accepted_rewards = achievement_stat["accepted_rewards"]
	
	SignalManager.achievements_updated.emit()
			
func on_equipment_crafted(equipment: EquipmentResource) -> void:
	the_almighty_storage_dictionary["equipment_crafted"] += 1
	
	if equipment in the_almighty_storage_dictionary["unique_equipment_crafted"]:
		return
	
	the_almighty_storage_dictionary["unique_equipment_crafted"].append(equipment)

func on_battle_end(win: bool) -> void:
	if win:
		on_win()
			
	else:
		on_loss()
	
	update_hero_stats()
	
	#await all changes to happen
	await get_tree().create_timer(0.5).timeout
	
	set_values_to_zero()
	
	for hero in TeamManager._all_heroes:
		the_almighty_storage_dictionary["hero_levels"].append(hero.lvl)
	
	for lvl in the_almighty_storage_dictionary["hero_levels"]:
		the_almighty_storage_dictionary["hero_total_levels"] += lvl
		
		if lvl > the_almighty_storage_dictionary["highest_level_hero"]:
			the_almighty_storage_dictionary["highest_level_hero"] = lvl
	
	for loot in InventoryManager._all_loot:
		if loot.quantity >= 1:
			if !loot in the_almighty_storage_dictionary["unique_loot"]:
				the_almighty_storage_dictionary["unique_loot"].append(loot)
	
	update_achievements()
	
func on_win() -> void:
	the_almighty_storage_dictionary["wins"] += 1
	update_hero_stats_win_losses("hero_stats", "enemy_hero_stats")
	
	if MatchDataManager.team_hero1["deaths"] <= 0 and MatchDataManager.team_hero2["deaths"] <= 0:
		the_almighty_storage_dictionary["wins_without_deaths"] += 1

func check_if_unclaimed_rewards() -> bool:
	for achievement in all_achievements:
		if achievement.ach_current_step > achievement.ach_accepted_rewards:
			return true
	return false

func on_loss() -> void:
	the_almighty_storage_dictionary["losses"] += 1
	update_hero_stats_win_losses("enemy_hero_stats", "hero_stats")

func update_hero_stats_win_losses(winner: String, loser: String) -> void:
	for hero_stats in the_almighty_storage_dictionary[winner]:
			for match_hero_stats in MatchDataManager.array_of_hero_dics:
				if hero_stats["hero"] == match_hero_stats["hero_res"]:
					hero_stats["wins"] += 1
	
	for hero_stats in the_almighty_storage_dictionary[loser]:
			for match_hero_stats in MatchDataManager.array_of_hero_dics:
				if hero_stats["hero"] == match_hero_stats["hero_res"]:
					hero_stats["losses"] += 1

func set_values_to_zero() -> void:
	the_almighty_storage_dictionary["hero_levels"].clear()
	the_almighty_storage_dictionary["hero_total_levels"] = 0

func update_hero_stats() -> void:
	check_and_update_hero_stats("hero_stats")
	check_and_update_hero_stats("enemy_hero_stats")
 
func check_and_update_hero_stats(key: String) -> void:
	for hero_stats in the_almighty_storage_dictionary[key]:
		for match_hero_stats in MatchDataManager.array_of_hero_dics:
			if hero_stats["hero"] == match_hero_stats["hero_res"]:
				hero_stats["kills"] += match_hero_stats["kills"] 
				hero_stats["deaths"] += match_hero_stats["deaths"] 

func check_if_new_heroes() -> void:
	check_and_add_heroes("hero_stats", TeamManager._all_heroes)
	check_and_add_heroes("enemy_hero_stats", TeamManager._all_enemy_heroes)

func check_and_add_heroes(key: String, heroes: Array) -> void:
	if the_almighty_storage_dictionary[key].size() < heroes.size():
		for hero in heroes:
			var hero_stats_entry: Dictionary = {
			"hero": hero,
			"wins": 0,
			"losses": 0,
			"kills": 0,
			"deaths": 0,
			}
			the_almighty_storage_dictionary[key].append(hero_stats_entry)

func check_and_add_achievement_stats() -> void:
	if all_achievements.size() > the_almighty_storage_dictionary["achievement_stats"].size():
		for achievement in all_achievements:
			var achievement_save_data: Dictionary = {
			"res": achievement,
			"index": achievement.ach_index,
			"accepted_rewards": 0,
			}
			the_almighty_storage_dictionary["achievement_stats"].append(achievement_save_data)
