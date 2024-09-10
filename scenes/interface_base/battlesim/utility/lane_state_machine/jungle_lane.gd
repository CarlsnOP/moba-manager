extends LaneState
class_name JungleLane

var jungle_manager: Node
var jungle_camps: Array

func enter():
	await get_tree().physics_frame
	jungle_manager = get_tree().get_first_node_in_group("jungle_manager")
	
	if jungle_manager.has_method("get_jungle"):
		jungle_camps = jungle_manager.get_jungle()

func exit():
	pass

func get_jungle_array() -> Array:
	return jungle_camps
