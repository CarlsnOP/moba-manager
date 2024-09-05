extends CharacterBody2D

enum LANE { TOP, BOT, JUNGLE }
enum STATE { WALK, ATTACK, IDLE, DEAD }

@onready var health_bar = %HealthBar
@onready var att_timer = %AttTimer
@onready var ai_manager = %AiManager

@export_category("Stats:")
@export var _health := 200.0
@export var _damage := 75.0
@export var _ability_power := 30
@export var _move_speed := 0.1
@export var _att_speed := 1.0

@export_category("Lane:")
@export var lane_points: NodePath

#Other vars
var _state: STATE
var _target = null
var _dead := false
var _target_pos: Vector2

var _waypoints := []
var _current_wp := 0

func _ready():
	setup()
	set_state(STATE.IDLE)

func _physics_process(delta):
	move(delta)

func setup() -> void:
	att_timer.wait_time = _att_speed
	health_bar.setup(_health)

func move(delta) -> void:
	var target_pos = ai_manager.get_nearest_point(position, 0)
	move_towards(target_pos, delta)
	
func move_towards(target_position: Vector2, delta) -> void:
	var direction = (target_position - position).normalized()
	velocity = direction * _move_speed * delta
	move_and_slide()

func set_state(new_state: STATE) -> void:
	if new_state == _state:
		return
	
	_state = new_state
	
	match _state:
		STATE.IDLE:
			_dead = true

func deal_damage(dmg: float) -> void:
	if _target != null:
		if _target.has_method("take_damage"):
			_target.take_damage(dmg)
	else:
		set_state(STATE.WALK)
		att_timer.stop()

func die() -> void:
	queue_free()

func _on_attack_range_body_entered(body):
	set_state(STATE.ATTACK)
	if _target == null:
		_target = body
		att_timer.start()

func _on_att_timer_timeout():
	deal_damage(_damage)

func _on_health_bar_died():
	die()