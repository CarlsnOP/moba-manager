class_name AggressiveState
extends State

# We want this state to:
#Focus enemy hero/tower if close to our minion
#If enemy hero is low, we want to chase
#if tower is low, we want to try and kill

@export var actor: PhysicsBody2D
@export var stats_component: StatsComponent
@export var state_machine_component: StateMachineComponent
@export var navigation_agent: NavigationAgent2D
@export var attack_component: AttackComponent
@export var lane_manager_component: LaneManagerComponent
@export var hitbox_component: HitboxComponent

var entity_groups := [ "hero", "minion", "tower", "nexus" ]

#use this incase we try to kill tower
func exit() -> void:
	pass

func update(_delta) -> void:
	#Check what lane our hero is on and sets group to it
	set_lane_group()
	
	#Depending if it is enemy hero or not, we set possible enemies and friends currently in tree
	set_possible_targets_and_friendlies()
	
	#Sets our navigation to the ally closest to an enemy
	find_closest_ally_to_enemy()

func set_lane_group() -> void:
	if lane_manager_component.top_lane:
		lane_group = "top"
	else:
		lane_group = "bot"

func set_possible_targets_and_friendlies() -> void:
	if stats_component.enemy:
		possible_targets = get_tree().get_nodes_in_group("team")
		possible_friendlies = get_tree().get_nodes_in_group("enemy")
		
	elif !stats_component.enemy:
		possible_targets = get_tree().get_nodes_in_group("enemy")
		possible_friendlies = get_tree().get_nodes_in_group("team")

func find_closest_ally_to_enemy() -> void:
	nearest_friendly_distance = INF
	
	for possible_friend in possible_friendlies:
		if possible_friend.is_in_group(lane_group):
			
			for possible_target in possible_targets:
				var check_distance = possible_friend.global_position.distance_to(possible_target.global_position)
				
				if check_distance < nearest_friendly_distance:
					nearest_friendly_distance = check_distance
					closest_ally = possible_friend.global_position
					navigation_agent.set_target_position(closest_ally)
					
					#Checks if we have an ally with us, if not we will not attack
					if nearest_friendly_distance >= ALLY_TOO_FAR_AWAY:
						attack_component.current_target_hurtbox = null
					else:
						#Prioritizes units to attack in this order: Hero > Tower/Nexus > Minion
						focus_priority_target()

func focus_priority_target() -> void:
	if hitbox_component.targets_in_range.size() > 0:
		var priority := 0
		
		for possible_target in hitbox_component.targets_in_range:
			var parent_node = possible_target.get_parent()
			var target_groups = parent_node.get_groups()
			
			for group in entity_groups:
				if group in target_groups:
				
					match group:
						"hero":
							attack_component.current_target_hurtbox = possible_target
							priority = 3
							if parent_node.has_method("get_stats_component"):
								var targets_stats = parent_node.get_stats_component() as StatsComponent
								
								if targets_stats.health <= targets_stats.max_health * 0.3 and \
								stats_component.health >= stats_component.max_health * 0.6:
									state_machine_component.on_child_transition("ChasingState")
								
						"tower":
							if priority > 3:
								attack_component.current_target_hurtbox = possible_target
								priority = 2
						"nexus":
							if priority > 3:
								attack_component.current_target_hurtbox = possible_target
								priority = 2
						"minion":
							if priority > 2:
								attack_component.current_target_hurtbox = possible_target
								priority = 1
