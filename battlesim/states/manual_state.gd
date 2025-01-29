class_name ManualState
extends State


@export var state_machine_component: StateMachineComponent
@export var health_bar_component: HealthBarComponent
@export var navigation_component: NavigationComponent
@export var controller_component: ControllerComponent

var leave_manuel_state_wait_time := 1.0
var leave_manual_state_timer = Timer.new()

func _ready():
	setup_timer()
	controller_component.on_command_finished.connect(start_timer)
	
func setup_timer() -> void:
	add_child(leave_manual_state_timer)
	leave_manual_state_timer.wait_time = leave_manuel_state_wait_time
	leave_manual_state_timer.timeout.connect(leave_state)
	leave_manual_state_timer.one_shot = true
	
func start_timer() -> void:
	leave_manual_state_timer.start()

func leave_state() -> void:
	state_machine_component.update_state(health_bar_component.value)

func exit() -> void:
	navigation_component.clear_lanes()
	navigation_component.set_lane(navigation_component.last_assigned_lane)
