extends Node

var damage_mulitplier := 1.20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var parent = get_parent()
	parent._damage = parent._damage * damage_mulitplier
