class_name ControllerComponent
extends Node2D

const NEVER_LEAVE_MANUAL_STATE := 300

@export var actor: PhysicsBody2D
@export var state_machine_component: StateMachineComponent
@export var navigation_agent: NavigationAgent2D
@export var navigation_component: NavigationComponent
@export var stats_component: StatsComponent
@export var manual_state: ManualState


var leave_manuel_state_wait_time := 2.0
var listen_to_orders := false
var entity_clicked: PhysicsBody2D = null
var original_lane: bool
var mouse_pos: Vector2

func _ready():
	SignalManager.manual_wait_time_changed.connect(manual_wait_time_changed)
	SignalManager.on_minions_spawn.connect(on_minions_spawn)
	await get_tree().create_timer(1.0).timeout
	if !stats_component.enemy:
		for button in get_tree().get_nodes_in_group("clickable_component"):
			button.entity_clicked.connect(clicked_entity)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if listen_to_orders:
			handle_command_given()
			
			mouse_pos = get_global_mouse_position()
			
			manual_state.on_ground_clicked(mouse_pos)
				
				
func clicked_entity(node_clicked: PhysicsBody2D) -> void:
	if listen_to_orders:
		handle_command_given()
		manual_state.on_entity_clicked(node_clicked)

func handle_command_given() -> void:
	navigation_component.enable_navigation_whole_map()
	if !state_machine_component.current_state is ManualState:
		state_machine_component.on_child_transition("ManualState")

func manual_wait_time_changed(value: float) -> void:
	if value == 5:
		manual_state.leave_manual_state_timer.wait_time = NEVER_LEAVE_MANUAL_STATE
		return
		
	manual_state.leave_manual_state_timer.wait_time = value + 0.01

func on_minions_spawn() -> void:
	if !stats_component.enemy:
		for button in get_tree().get_nodes_in_group("clickable_component"):
			if not button.entity_clicked.is_connected(clicked_entity):
				button.entity_clicked.connect(clicked_entity)
