extends Control

@onready var log_label = %LogLabel

func on_save_game(saved_data:Array[SavedData]):
	var my_data = SavedData.new()
	my_data.scene_path = scene_file_path
	saved_data.append(my_data)

func on_before_load_game():
	get_parent().remove_child(self)
	queue_free()

func new_log(amount: int) -> void:
	log_label.text = "Rubberduckies earned: %s" % amount
