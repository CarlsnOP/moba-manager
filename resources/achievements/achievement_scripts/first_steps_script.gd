extends Node

static func update_achievement(achievement: AchievementResource):
	if !achievement.ach_completed:
		achievement.ach_progress = AchievementManager.the_almighty_storage_dictionary["wins"]
		if step_one(achievement):
			achievement.ach_current_step = 1
			achievement.ach_1st_description = "Win"
			achievement.ach_2nd_description = "battles:"
			
			if step_one(achievement):
				achievement.ach_current_step = 2
				
				if step_one(achievement):
					achievement.ach_current_step = 3
					finale_step(achievement)

	
static func step_one(achievement: AchievementResource) -> bool:
	if achievement.ach_progress >= achievement.ach_requirement[achievement.ach_current_step]:
		return true

	return false

static func finale_step(achievement: AchievementResource) -> void:
	if achievement.ach_progress >= achievement.ach_requirement[achievement.ach_current_step]:
		achievement.ach_completed = true
