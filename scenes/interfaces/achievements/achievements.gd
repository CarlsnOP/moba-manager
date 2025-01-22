class_name Achievements
extends Control

@onready var achievement_log = %AchievementLog

func _ready():
	SignalManager.achievements_updated.connect(open)

func open() -> void:
	achievement_log.display()


func _on_quit_button_pressed():
	SignalManager.new_interface.emit(InterfaceManager.INTERFACE_STATE.BATTLESIM)
