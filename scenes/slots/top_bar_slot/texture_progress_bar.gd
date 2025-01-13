extends TextureProgressBar

var actor: Control
var has_cooldown = false

func setup(a: Control):
	actor = a
	value = max_value

func late_setup() -> void:
	has_cooldown = true
	max_value = actor.cooldown_timer_ref.wait_time
	
func _process(_delta):
	if has_cooldown:
		value = max_value - actor.cooldown_timer_ref.time_left
