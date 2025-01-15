extends Node


static func update_achievement(achievement: AchievementResource):
	if !achievement.ach_completed:
		achievement.ach_progress = AchievementManager.the_almighty_storage_dictionary["unique_equipment_crafted"].size()
		if step_one(achievement):
			achievement.ach_current_step = 1
			if step_one(achievement):
				achievement.ach_current_step = 2
				if step_one(achievement):
					achievement.ach_current_step = 3
					achievement.ach_1st_description = "Craft all possible items"
					achievement.ach_2nd_description = ""
					finale_step(achievement)

	
static func step_one(achievement: AchievementResource) -> bool:
	if achievement.ach_progress >= achievement.ach_requirement[achievement.ach_current_step]:
		return true

	return false

static func finale_step(achievement: AchievementResource) -> void:
	if achievement.ach_progress >= achievement.ach_requirement[achievement.ach_current_step]:
		achievement.ach_completed = true
