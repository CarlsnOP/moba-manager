extends CharacterBody2D

enum TEAM { BUDDY, BULLY }

@export_category("Stats:")
@export var team: TEAM
@export var _health := 200.0
@export var _damage := 75.0
@export var ability_power := 30
@export var move_speed := 90.0
@export var _att_speed := 1.0
@export var _initial_state: State
@export var _initial_lane: LaneState
@export var jungler: bool

@onready var health_bar = %HealthBar
@onready var att_timer = %AttTimer
@onready var lane_state_machine = %LaneStateMachine
@onready var nav_agent = $NavAgent
@onready var state_machine = %StateMachine
@onready var respawn_timer: Timer = %RespawnTimer
@onready var respawn_enemy: Marker2D = $"../RespawnEnemy"


var _target = null
var _enemies_in_range := []
var current_state: State
var _dead_pos := Vector2(0, 0)
var _respawn_time := 15.0


func _ready():
	setup()
	
func setup() -> void:
	health_bar.setup(_health)
	att_timer.wait_time = _att_speed
	respawn_timer.wait_time = _respawn_time

func new_game() -> void:
	queue_free()

func _physics_process(_delta):
	set_target()

func set_target() -> void:
	if _target != null:
		return
	
	for enemy in _enemies_in_range:
		if enemy == null:
			pass
		else:
			_target = enemy
			att_timer.start()
	
	if _target == null:
		att_timer.stop()
	return

func deal_damage(dmg: float) -> void:
	if _target != null:
		if _target.has_method("take_damage"):
			_target.take_damage(dmg)

func take_damage(dmg: float) -> void:
	health_bar.take_damage(dmg)

func die() -> void:
	set_physics_process(false)
	state_machine.on_death()
	global_position = _dead_pos
	respawn_timer.start()

func respawn() -> void:
	global_position = respawn_enemy.global_position
	health_bar.setup(_health)
	state_machine.on_respawn()
	set_physics_process(true)

func _on_attack_range_body_entered(body):
	if body.is_in_group("jungle"):
		_enemies_in_range.append(body)
		
	if body.is_in_group("buddy"):
		_enemies_in_range.append(body)

func _on_attack_range_body_exited(body):
	if _enemies_in_range.has(body):
		_enemies_in_range.erase(body)

	if _target == body:
		_target = null

func _on_att_timer_timeout():
	deal_damage(_damage)

func _on_health_bar_died():
	die()

func get_initial_state() -> State:
	return _initial_state

func get_initial_lane() -> LaneState:
	return _initial_lane

func get_minion_array() -> Array[PathFollow2D]:
	return lane_state_machine.get_minion_array()

func get_jungle_array() -> Array:
	return lane_state_machine.get_jungle_array()

func _on_respawn_timer_timeout() -> void:
	respawn()
