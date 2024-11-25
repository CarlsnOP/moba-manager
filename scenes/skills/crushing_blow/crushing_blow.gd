extends Node

var damage_mulitplier := 1.20

func _ready() -> void:
	var parent = get_parent()
	parent._damage = parent._damage * damage_mulitplier


	
