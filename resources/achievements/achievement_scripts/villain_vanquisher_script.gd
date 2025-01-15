extends Node

const BRUCE = preload("res://resources/heroes/enemy/bruce.tres")
const SHEILA = preload("res://resources/heroes/enemy/sheila.tres")
const VINNY = preload("res://resources/heroes/enemy/vinny.tres")

static func update_achievement(achievement: AchievementResource):
	if !achievement.ach_completed:
		if step_one(achievement):
			achievement.ach_current_step = 1
			achievement.ach_1st_description = "Defeat Sneaky Sheila"
			if step_two(achievement):
				achievement.ach_current_step = 2
				achievement.ach_1st_description = "Defeat Brutal Bruce"
				if step_three(achievement):
					achievement.ach_current_step = 3
					achievement.ach_1st_description = "Defeat all three bullies"
					step_four(achievement)

	
static func step_one(achievement: AchievementResource) -> bool:
	for hero in AchievementManager.the_almighty_storage_dictionary["enemy_hero_stats"]:
		if hero["hero"] == VINNY:
			achievement.ach_progress = hero["losses"]
			if hero["losses"] >= achievement.ach_requirement[0]:
				return true
	return false

static func step_two(achievement: AchievementResource) -> bool:
	for hero in AchievementManager.the_almighty_storage_dictionary["enemy_hero_stats"]:
		if hero["hero"] == SHEILA:
			achievement.ach_progress = hero["losses"]
			if hero["losses"] >= achievement.ach_requirement[1]:
				achievement.ach_current_step = 2
				return true
	return false

static func step_three(achievement: AchievementResource) -> bool:
	for hero in AchievementManager.the_almighty_storage_dictionary["enemy_hero_stats"]:
		if hero["hero"] == BRUCE:
			achievement.ach_progress = hero["losses"]
			if hero["losses"] >= achievement.ach_requirement[2]:
				achievement.ach_current_step = 3
				return true
	return false

static func step_four(achievement: AchievementResource) -> void:
	var hero_losses_required = ["BRUCE", "SHEILA", "VINNY"]
	var hero_losses_met = 0
	
	for hero in AchievementManager.the_almighty_storage_dictionary["enemy_hero_stats"]:
		
		if hero["hero"] == hero_losses_required and hero["losses"] >= achievement.ach_requirement[3]:
			hero_losses_met += 1
	
	achievement.ach_progress = hero_losses_met
	
	if hero_losses_met == hero_losses_required.size():
		achievement.ach_completed = true
