extends VBoxContainer

const ACHIEVEMENT_SLOT = preload("res://scenes/slots/achievement_slot/achievement_slot.tscn")


func display() -> void:
	if AchievementManager.all_achievements.size() > get_children().size():
		for achievement in AchievementManager.all_achievements:
			var new_ach_slot = ACHIEVEMENT_SLOT.instantiate()
			add_child(new_ach_slot)
			new_ach_slot.setup(achievement)
	else:
		for child in get_children():
			child.update()
