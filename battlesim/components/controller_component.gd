class_name ControllerComponent
extends Node2D

signal on_command_finished


@export var actor: PhysicsBody2D
@export var state_machine_component: StateMachineComponent
@export var navigation_agent: NavigationAgent2D
@export var navigation_component: NavigationComponent


var listen_to_orders := false
var navigation_map_ref: TileMapLayer
var original_lane: bool
var mouse_pos: Vector2

func _ready():
	navigation_map_ref = get_tree().get_first_node_in_group("navigation_map")

func _process(_delta):
	if listen_to_orders:
		if Input.is_action_just_pressed("control_unit"):
			handle_command_given()
			#Figure out if we clicked on an enemy
			navigation_agent.set_target_position(mouse_pos)
			on_command_finished.emit()

func handle_command_given() -> void:
	mouse_pos = get_global_mouse_position()
	navigation_component.enable_navigation_whole_map()
	state_machine_component.on_child_transition("ManualState")

func move_command() -> void:
	navigation_agent.set_target_position(mouse_pos)
	on_command_finished.emit()
	
func attack_command() -> void:
	pass
