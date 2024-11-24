extends Node

var _damage_reduction := 0.20


func _ready() -> void:
	#Connect to the tree, every time a node is added, it runs func _on_node_added()
	get_tree().connect("node_added", Callable(self, "_on_node_added"))
	get_parent().set_dmg_red(-_damage_reduction)

func _on_node_added(node: Node) -> void:
	if node.is_in_group("buddy"):
	# Apply the aura effect if the method exists
		if node.has_method("set_dmg_red"):
			node.set_dmg_red(-_damage_reduction)
