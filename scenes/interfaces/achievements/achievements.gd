class_name Achievements
extends Control

@onready var achievement_log = %AchievementLog

func _ready():
	SignalManager.achievements_updated.connect(open)

func open() -> void:
	achievement_log.display()
