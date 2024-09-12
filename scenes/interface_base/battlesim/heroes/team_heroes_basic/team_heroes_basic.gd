extends CharacterBody2D

enum TEAM { BUDDY, BULLY }

@export_category("Stats:")
@export var team: TEAM
@export var move_speed := 90.0
@export var _att_speed := 1.0
@export var _initial_state: State
@export var _initial_lane: LaneState
@export var jungler: bool
@export var _hero: HeroResource

@onready var nav_agent = %NavAgent
@onready var health_bar = %HealthBar
@onready var att_timer = %AttTimer
@onready var state_machine = %StateMachine
@onready var lane_state_machine = %LaneStateMachine
@onready var sprite_2d = %Sprite2D


var _target = null
var _enemies_in_range := []
var current_state: State
var _health: float
var _damage: float
var _ability_power: float

func _ready():
	setup()
	
func setup() -> void:
	sprite_2d.texture = _hero.hero_icon
	_health = _hero.health
	_damage = _hero.attack_damage
	_ability_power = _hero.ability_power
	health_bar.setup(_health)
	att_timer.wait_time = _att_speed

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
	queue_free()

func _on_attack_range_body_entered(body):
	if body.is_in_group("jungle") and jungler:
		_enemies_in_range.append(body)
		
	if body.is_in_group("bully"):
		_enemies_in_range.append(body)

func _on_attack_range_body_exited(body):
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
