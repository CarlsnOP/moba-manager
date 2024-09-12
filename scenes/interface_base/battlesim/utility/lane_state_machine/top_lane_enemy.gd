extends LaneState
class_name TopLaneEnemy


var top_lane: Path2D

func _ready():
	top_lane = get_tree().get_first_node_in_group("top_lane_enemy")
	
	top_lane.connect("child_entered_tree", Callable(self, "_on_minion_added"))
	top_lane.connect("child_exiting_tree", Callable(self, "_on_minion_removed"))
	
func enter():
	await get_tree().physics_frame
	update_minions_list()

func exit():
	pass

func update_minions_list() -> void:
	minions.clear()
	for child in top_lane.get_children():
		if child is PathFollow2D:
			minions.append(child)

func get_minion_array() -> Array[PathFollow2D]:
	return minions
