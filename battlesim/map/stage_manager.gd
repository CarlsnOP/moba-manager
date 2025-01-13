class_name StageManager
extends Control

const BASE_HP_BOOST := 10
const BASE_AD_BOOST := 5
const BASE_AP_BOOST := 5

@onready var stage_label = %StageLabel


var current_stage := 1
var highest_stage := 1

func _ready():
	SignalManager.on_battle_end.connect(on_battle_end)
	
func on_battle_end(win: bool) -> void:
	if !win:
		if current_stage > 1:
			current_stage -= 1
			return
		return
	
	current_stage += 1
	
	if current_stage > highest_stage:
		highest_stage = current_stage

func update_stage_label() -> void:
	stage_label.text = "Stage: " + str(current_stage)
