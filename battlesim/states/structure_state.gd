class_name StructureState
extends State

@export var actor: Node2D
@export var stats_component: StatsComponent
@export var attack_component: AttackComponent
@export var hitbox_component: HitboxComponent

func update(_delta):
	for target in hitbox_component.targets_in_range:
		if target == null:
			return
		else:
			attack_component.current_target_hurtbox = target

#Not needed
func physics_update(_delta):
	pass
