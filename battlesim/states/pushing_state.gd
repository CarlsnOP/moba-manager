class_name PushingState
extends State

@export var actor: CharacterBody2D
@export var stats_component: StatsComponent
@export var navigation_agent: NavigationAgent2D
@export var move_component: MoveComponent

var nearest_distance = INF

func _process(delta):
	set_new_destination(delta)

func set_new_destination(delta) -> void:
	var possible_targets: Array[Node] = []
	
	if stats_component.enemy:
		possible_targets = get_tree().get_nodes_in_group("team")
	else:
		possible_targets = get_tree().get_nodes_in_group("enemy")
	
	for possible_target in possible_targets:
		#Checking if we can navigate to target, if not go to next target
		navigation_agent.target_position = possible_target.global_position
		if !navigation_agent.is_target_reachable():
			return
		
		var next_path_position: Vector2 = navigation_agent.get_next_path_position()
		move_component.move_to(delta, next_path_position)
		
