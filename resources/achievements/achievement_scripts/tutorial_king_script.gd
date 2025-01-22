extends Node


static func update_achievement(achievement: AchievementResource):
	if !achievement.ach_completed:
		if TeamManager.bot != null and TeamManager.top != null:
			achievement.ach_current_step += 1
			achievement.ach_completed = true

static func handle_reward() -> void:
	InventoryManager.get_loot_ducky(1)
