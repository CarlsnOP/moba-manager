class_name AggressiveState
extends State

# We want this state to:
#Focus enemy hero/tower if close to our minion
#If enemy hero is low, we want to chase
#if tower is low, we want to try and kill

@export var actor: PhysicsBody2D
@export var stats_component: StatsComponent
@export var navigation_agent: NavigationAgent2D
@export var attack_component: AttackComponent
@export var lane_manager_component: LaneManagerComponent

var nearest_friendly_distance = INF
var closest_target: Vector2
var closest_ally: Vector2
var target: Node2D = null

#use this incase we try to kill tower
func exit() -> void:
	pass

func update(_delta) -> void:
	var possible_targets: Array[Node] = []
	var possible_friendlies: Array[Node] = []
	nearest_friendly_distance = INF
	
	if stats_component.enemy:
		possible_targets = get_tree().get_nodes_in_group("team")
		possible_friendlies = get_tree().get_nodes_in_group("enemy")
		
	elif !stats_component.enemy:
		possible_targets = get_tree().get_nodes_in_group("enemy")
		possible_friendlies = get_tree().get_nodes_in_group("team")
	
	for possible_friend in possible_friendlies:
		if lane_manager_component.top_lane:
			if possible_friend.is_in_group("top"):
				for possible_target in possible_targets:
					var check_distance = possible_friend.global_position.distance_to(possible_target.global_position)
					
					if check_distance < nearest_friendly_distance:
						nearest_friendly_distance = check_distance
						closest_ally = possible_friend.global_position
						navigation_agent.set_target_position(closest_ally)
						attack_component.current_target_hurtbox = possible_target.get_hurtbox()
		else:
			if possible_friend.is_in_group("bot"):
				for possible_target in possible_targets:
					var check_distance = possible_friend.global_position.distance_to(possible_target.global_position)
					
					if check_distance < nearest_friendly_distance:
						nearest_friendly_distance = check_distance
						closest_ally = possible_friend.global_position
						navigation_agent.set_target_position(closest_ally)
						attack_component.current_target_hurtbox = possible_target.get_hurtbox()
