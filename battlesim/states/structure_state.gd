class_name StructureState
extends State

@export var actor: Node2D
@export var stats_component: StatsComponent
@export var attack_component: AttackComponent
@export var hitbox_component: HitboxComponent

var has_target := false

func update(_delta):
	if hitbox_component.targets_in_range.size() > 0:
		attack_component.current_target_hurtbox = hitbox_component.targets_in_range[0]
