extends LaneState
class_name BotLaneEnemy


var bot_lane: Path2D

func _ready():
	bot_lane = get_tree().get_first_node_in_group("bot_lane_enemy")
	await get_tree().physics_frame
	bot_lane.connect("child_entered_tree", Callable(self, "_on_minion_added"))
	bot_lane.connect("child_exiting_tree", Callable(self, "_on_minion_removed"))

func enter():
	await get_tree().physics_frame
	update_minions_list()

func exit():
	pass

func update_minions_list() -> void:
	minions.clear()
	for child in bot_lane.get_children():
		if child is PathFollow2D:
			minions.append(child)

func get_minion_array() -> Array[PathFollow2D]:
	return minions
