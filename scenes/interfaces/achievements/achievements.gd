extends Control

@onready var achievement_log = %AchievementLog

func open() -> void:
	achievement_log.display()
