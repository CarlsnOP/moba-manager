class_name DebugComponent
extends Node

@export var actor: PhysicsBody2D
@export var state_machine_component: StateMachineComponent
@export var hide := true

var debug_label: Label = Label.new()

# Called when the node enters the scene tree for the first time.
func _ready():

	call_deferred("add_child", debug_label)
	debug_label.label_settings = LabelSettings.new()

	var color = "#FFF"

	debug_label.label_settings.font_color = color
	debug_label.label_settings.font_size = 20
	debug_label.label_settings.outline_color = "#000"
	debug_label.label_settings.outline_size = 3
	
	if hide:
		debug_label.hide()


func _process(_delta):
	debug_label.global_position = actor.global_position + Vector2(-70, 40)

	debug_label.text = str(state_machine_component.current_state.name)
