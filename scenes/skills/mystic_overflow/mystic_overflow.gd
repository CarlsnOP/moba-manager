extends Node

@onready var ability_timer: Timer = %AbilityTimer

var parent: Node2D
var ability_ready := true
var ability_cooldown := 20.0

func _ready() -> void:
	ability_timer.wait_time = ability_cooldown
	parent = get_parent()
	
	if parent:
		var timer = parent.get_node("AttTimer")

		if timer and timer is Timer:
			timer.connect("timeout", Callable(self, "_on_att_timer_timeout"))

func _on_att_timer_timeout() -> void:
	if parent._target != null and ability_ready:
		magic_attack()
		
func magic_attack() -> void:
	parent._target.take_damage(parent._ability_power, parent)
	ability_ready = false
	ability_timer.start()

func _on_ability_timer_timeout() -> void:
	ability_ready = true
