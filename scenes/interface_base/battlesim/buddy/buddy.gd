extends PathFollow2D

enum BUDDY_STATE { WALK, ATTACK }

@onready var att_timer = %AttTimer

#Stats
var _health := 200.0
var _damage := 50.0
var _move_speed := 0.1
var _att_speed := 1.0

#Other vars
var _state: BUDDY_STATE
var _target = null

func _ready():
	setup()
	set_state(BUDDY_STATE.WALK)

func _physics_process(delta):
	if _state == BUDDY_STATE.WALK:
		progress_ratio += _move_speed * delta

func setup() -> void:
	att_timer.wait_time = _att_speed

func set_state(new_state: BUDDY_STATE) -> void:
	if new_state == _state:
		return
	
	_state = new_state

func take_damage(dmg: float) -> void:
	_health -= dmg
	
	if _health <= 0:
		queue_free()

func deal_damage(dmg: float) -> void:
	if _target != null:
		if _target.has_method("take_damage"):
			_target.take_damage(dmg)
	else:
		set_state(BUDDY_STATE.WALK)
		att_timer.stop()

func _on_attack_range_body_entered(body):
	set_state(BUDDY_STATE.ATTACK)
	if _target == null:
		_target = body
		att_timer.start()


func _on_att_timer_timeout():
	deal_damage(_damage)
