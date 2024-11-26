extends PathFollow2D

enum STATE { WALK, ATTACK }

@onready var att_timer = %AttTimer
@onready var health_bar = %HealthBar

@export_category("Stats:")
@export var name_string := "Buddy"
var _health := CheatManager._health
var _damage := CheatManager._damage
@export var _move_speed := 0.1
@export var _att_speed := 1.0


var _current_state: STATE
var _target = null
var _enemies_in_range := []

func _ready():
	setup()
	set_state(STATE.WALK)

func _physics_process(delta):
	set_target()
	
	if _current_state == STATE.WALK:
		progress_ratio += _move_speed * delta

func setup() -> void:
	health_bar.setup(_health, _health)
	att_timer.wait_time = _att_speed

func new_game() -> void:
	queue_free()

func set_state(new_state: STATE) -> void:
	if new_state == _current_state:
		return
	
	_current_state = new_state

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
		set_state(STATE.WALK)
		att_timer.stop()
	return

func deal_damage(dmg: float) -> void:
	if _target != null:
		if _target.has_method("take_damage"):
			_target.take_damage(dmg, self)
	else:
		set_state(STATE.WALK)

func die() -> void:
	queue_free()

func _on_attack_range_body_entered(body):
	if body.is_in_group("bully"):
		set_state(STATE.ATTACK)
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
