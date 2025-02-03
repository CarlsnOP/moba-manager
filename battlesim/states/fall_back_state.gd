class_name FallBackState
extends State

#We will go into this state when we detect danger.
#Fall back and then go back to normal state
#For example taking tower/nexus dmg while minion is close

@export var actor: Hero
@export var navigation_agent: NavigationAgent2D
@export var state_machine_component: StateMachineComponent
@export var attack_component: AttackComponent
@export var hurtbox_component: HurtboxComponent

var enemy_hitbox: HitboxComponent

func enter() -> void:
	attack_component.current_target_hurtbox = null
	
	var enemy_node = hurtbox_component.last_hitter
	
	if enemy_node == null:
		state_machine_component.update_state.unbind(1)
		return
		
	var enemy_radius: float = 0.0
	var enemy_position: Vector2 = enemy_node.position
	
	for child in enemy_node.get_children():
		if child is HitboxComponent:
			enemy_hitbox = child
			var enemy_range = child.get_child(0) as CollisionShape2D
			
			if enemy_range and enemy_range.shape is CircleShape2D:
				enemy_radius = enemy_range.shape.radius
				break
	
	if enemy_radius > 0.0:
		var escape_direction = (actor.position - enemy_position).normalized()
		var escape_target_position = enemy_position + escape_direction * (enemy_radius + 20)
		navigation_agent.set_target_position(escape_target_position)
			

func update(_delta) -> void:
	if enemy_hitbox != null:
		if !hurtbox_component in enemy_hitbox.targets_in_range:
			if !state_machine_component.current_state is DeadState:
				state_machine_component.on_child_transition("TransitionState")
