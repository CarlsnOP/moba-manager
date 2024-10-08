extends CharacterBody2D

@onready var health_bar = %HealthBar
@onready var att_timer = $AttTimer

@export_category("Stats:")
@export var _damage := 30.0
@export var _health := 1000.0
@export var _att_speed := 1.5

var _target = null
var _enemies_in_range := []

func _ready():
	setup()

func _process(_delta):
	set_target()

func setup() -> void:
	health_bar.setup(_health)
	att_timer.wait_time = _att_speed

func new_game() -> void:
	queue_free()

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

func get_structure_position() -> Vector2:
	return global_position

func take_damage(dmg: float) -> void:
	health_bar.take_damage(dmg)

func deal_damage(dmg: float) -> void:
	if _target != null:
		if _target.has_method("take_damage"):
			_target.take_damage(dmg)

func _on_attack_range_body_entered(body):
	_enemies_in_range.append(body)

func _on_attack_range_body_exited(body):
	if _enemies_in_range.has(body):
		_enemies_in_range.erase(body)

	if _target == body:
		_target = null

func _on_att_timer_timeout():
	deal_damage(_damage)

func _on_health_bar_died():
	queue_free()
