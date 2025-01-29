class_name DefensiveState
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
@export var hitbox_component: HitboxComponent
@export var state_machine_component: StateMachineComponent


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
						attack_component.allow_movement()
					else:
						#Attacks the first target that enters our hitbox
						priotize_first_target_in_range()

func priotize_first_target_in_range() -> void:
	if hitbox_component.targets_in_range.size() > 0:
		attack_component.current_target_hurtbox = hitbox_component.targets_in_range[0]
