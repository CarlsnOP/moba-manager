class_name ChasingState
extends State


@export var attack_component: AttackComponent
@export var stats_component: StatsComponent
@export var navigation_agent: NavigationAgent2D
@export var state_machine_component: StateMachineComponent
@export var hitbox_component: HitboxComponent
@export var health_bar_component: HealthBarComponent

func update(_delta) -> void:
	if stats_component.health >= stats_component.max_health * 0.5 and \
	hitbox_component.targets_in_range.size() > 0:
		for target in hitbox_component.targets_in_range:
			if target == attack_component.current_target_hurtbox:
				navigation_agent.set_target_position(attack_component.current_target_hurtbox.global_position)
			else:
				state_machine_component.update_state(health_bar_component.value)
			
	else:
		state_machine_component.update_state(health_bar_component.value)
