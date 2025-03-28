extends PanelContainer

const CONFIRMATION_DIALOG = preload("res://scenes/utility/confirmation_dialog/confirmation_dialog.tscn")

@onready var tutorial_page = $"../TutorialPage"

func _ready():
	hide()
	SignalManager.restart_match.connect(hide_warning)
	SignalManager.show_change_warning.connect(show_warning)
	SignalManager.hero_selected.connect(show_warning)
	
func show_warning() -> void:
	if tutorial_page == null:
		show()

func hide_warning() -> void:
	hide()


func _on_restart_match_button_pressed():
	var temp = get_tree().get_first_node_in_group("confirmation_dialog")
	if temp:
		temp.queue_free()
	else:
		ObjectMakerManager.instantiate_scene(CONFIRMATION_DIALOG)
