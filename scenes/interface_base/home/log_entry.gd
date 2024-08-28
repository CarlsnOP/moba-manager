extends Control

@onready var log_label = %LogLabel

var saved_amount: int

func on_save_game(saved_data:Array[SavedData]):
	var my_data = SavedLogData.new()
	my_data.scene_path = scene_file_path
	my_data.amount = saved_amount
	saved_data.append(my_data)

func on_before_load_game():
	get_parent().remove_child(self)
	queue_free()

func on_load_game(saved_data:SavedData):
	if saved_data is SavedLogData:
		log_label.text = "Rubberduckies earned: %s" % saved_data.amount
		saved_amount = saved_data.amount
	var next_parent = get_node("/root/Homepage/CanvasLayer/MarginContainer/Interface/Home/PC/MC/VB/PC/VB")
	get_parent().remove_child(self)
	next_parent.add_child(self)
	SignalManager.on_log_entry.emit(self)


func new_log(amount: int) -> void:
	log_label.text = "Rubberduckies earned: %s" % amount
	saved_amount = amount
