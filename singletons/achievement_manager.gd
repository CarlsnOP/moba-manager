extends Node

var all_achievements: Array[AchievementResource] = []
var ach_index := 0


func _ready():
	for file in DirAccess.get_files_at("res://resources/achievements/resources/"):
		var resource_file = "res://resources/achievements/resources/" + file
		var achievement: AchievementResource = load(resource_file) as AchievementResource
		achievement.ach_index += ach_index
		ach_index += 1
		all_achievements.append(achievement)
	
	SignalManager.update_achievements.connect(update_achievements)


func update_achievements() -> void:
	pass

func win_achievements() -> void:
	pass
