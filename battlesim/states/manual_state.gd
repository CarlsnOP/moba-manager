class_name ManualState
extends State


@export var state_machine_component: StateMachineComponent
@export var navigation_component: NavigationComponent
@export var navigation_agent: NavigationAgent2D
@export var controller_component: ControllerComponent
@export var attack_component: AttackComponent
@export var move_component: MoveComponent

var default_manuel_state_wait_time := 2.0
var leave_manual_state_timer = Timer.new()
var current_target: PhysicsBody2D = null
var check_if_entity_is_valid := false

func _ready():
	setup_timer()
	move_component.destination_reached.connect(start_timer)
	
func setup_timer() -> void:
	add_child(leave_manual_state_timer)
	leave_manual_state_timer.wait_time = default_manuel_state_wait_time
	leave_manual_state_timer.timeout.connect(leave_state)
	leave_manual_state_timer.one_shot = true

func update(_delta) -> void:
	if check_if_entity_is_valid:
		if is_instance_valid(current_target):
			for child in current_target.get_children():
				if child is StateMachineComponent:
					if child.current_state is DeadState:
						check_if_entity_is_valid = false
						leave_state()
					else:
						navigation_agent.set_target_position(current_target.global_position)
		else:
			check_if_entity_is_valid = false
			leave_state()
			
		
func on_entity_clicked(node_clicked: PhysicsBody2D) -> void:
	current_target = node_clicked
	
	for child in node_clicked.get_children():
		if child is HurtboxComponent:
			check_if_entity_is_valid = true
			attack_component.current_target_hurtbox = child
	
func on_ground_clicked(mouse_pos) -> void:
	check_if_entity_is_valid = false
	attack_component.current_target_hurtbox = null
	navigation_agent.set_target_position(mouse_pos)

func start_timer() -> void:
	leave_manual_state_timer.start()

func leave_state() -> void:
	if !state_machine_component.current_state is DeadState or !check_if_entity_is_valid:
		state_machine_component.on_child_transition("TransitionState")

func exit() -> void:
	navigation_component.set_lane(navigation_component.last_assigned_lane)
