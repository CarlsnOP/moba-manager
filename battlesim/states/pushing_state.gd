class_name PushingState
extends State

@export var actor: Node2D
@export var stats_component: StatsComponent
@export var navigation_agent: NavigationAgent2D
@export var attack_component: AttackComponent

var nearest_distance = INF
var closest_target = null

func update(_delta):
	set_new_destination()

func set_new_destination() -> void:
	nearest_distance = INF
	
	if stats_component.enemy:
		possible_targets = get_tree().get_nodes_in_group("team")
	elif !stats_component.enemy:
		possible_targets = get_tree().get_nodes_in_group("enemy")
	
	for possible_target in possible_targets:
		if possible_target is Nexus or possible_target is Tower:
			check_distance(possible_target)
			
		#Making sure the minion only targets units on the same navigation layer
		for child in possible_target.get_children():
			if child is NavigationAgent2D:
				var targets_navigation = child as NavigationAgent2D
				if targets_navigation.navigation_layers == navigation_agent.navigation_layers:
					check_distance(possible_target)

func check_distance(possible_target) -> void:
	var check_dis = actor.global_position.distance_to(possible_target.global_position)
						
	if check_dis < nearest_distance:
		nearest_distance = check_dis
		closest_target = possible_target.global_position
		navigation_agent.set_target_position(closest_target)
		attack_component.current_target_hurtbox = possible_target.get_hurtbox()
