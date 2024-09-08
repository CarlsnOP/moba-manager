extends LaneState
class_name BotLaneEnemy

var bot_lane: Path2D

func enter():
	bot_lane = get_tree().get_first_node_in_group("top_lane_enemy")
	
	bot_lane.connect("child_entered_tree", Callable(self, "_on_minion_added"))
	bot_lane.connect("child_exiting_tree", Callable(self, "_on_minion_removed"))
	await get_tree().physics_frame
	update_minions_list()
	
func exit():
	pass

func update(delta: float):
	pass
	
func physics_update(detla: float):
	pass

func update_minions_list() -> void:
	minions.clear()
	for child in bot_lane.get_children():
		if child is PathFollow2D:
			minions.append(child)