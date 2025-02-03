class_name StageManager
extends Control

const STAGE_INCREMENT := 0.03

@onready var stage_label = %StageLabel


var current_stage := 1
var highest_stage := 1

func _ready():
	SignalManager.on_battle_end.connect(on_battle_end)
	await get_tree().physics_frame
	update_stage_label()
	stage_label.show()
	
func on_battle_end(win: bool) -> void:
	if !win:
		if current_stage > 1:
			current_stage -= 1
			update_stage_label()
			return
		return
	
	current_stage += 1

	if current_stage > highest_stage:
		highest_stage = current_stage
		
	update_stage_label()

func update_stage_label() -> void:
	stage_label.text = "Stage: " + str(current_stage)

func get_stage_modifer() -> float:
	return current_stage * STAGE_INCREMENT
