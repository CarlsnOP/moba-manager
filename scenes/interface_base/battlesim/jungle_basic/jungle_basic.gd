extends CharacterBody2D


@onready var health_bar = %HealthBar
@onready var att_timer = %AttTimer

@export_category("Stats:")
@export var _health := 400.0
@export var _damage := 20.0
@export var _att_speed := 1.0

#Other vars
var _target = null

func _ready():
	setup()

func setup() -> void:
	att_timer.wait_time = _att_speed
	health_bar.setup(_health)

func deal_damage(dmg: float) -> void:
	if _target != null:
		if _target.has_method("take_damage"):
			_target.take_damage(dmg)
	else:
		att_timer.stop()

func take_damage(dmg: float) -> void:
	health_bar.take_damage(dmg)

func die() -> void:
	var parent = get_parent()
	if parent.has_method("respawn_mob"):
		parent.respawn_mob()
	queue_free()

func _on_attack_range_body_entered(body):
	if _target == null:
		_target = body
		att_timer.start()

func _on_health_bar_died():
	die()

func _on_att_timer_timeout():
	deal_damage(_damage)
