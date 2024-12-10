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

#Not needed
func physics_update(_delta):
	pass

func set_new_destination() -> void:
	var possible_targets: Array[Node] = []
	nearest_distance = INF
	
	if stats_component.enemy:
		possible_targets = get_tree().get_nodes_in_group("team")
	elif !stats_component.enemy:
		possible_targets = get_tree().get_nodes_in_group("enemy")
	
	for possible_target in possible_targets:
		var check_distance = actor.global_position.distance_to(possible_target.global_position)
			
		if check_distance < nearest_distance:
			nearest_distance = check_distance
			closest_target = possible_target.global_position
			navigation_agent.set_target_position(closest_target)
			attack_component.current_target_hurtbox = possible_target.get_hurtbox()
