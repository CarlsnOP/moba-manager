class_name ExplosiveFinaleScript
extends Node2D

var actor: Hero
var _parent: AbilityComponent
var skill_res: SkillResource
var stats_component: StatsComponent
var attack_component: AttackComponent
var death_component: DeathComponent
var hurtbox_component: HurtboxComponent
var explosive_finale_area2d := Area2D.new()
var explosive_finale_collision_shape := CollisionShape2D.new()
var circle := CircleShape2D.new()
var explosive_finale_radius := 150.0

func setup_skill(skill: SkillResource, parent: AbilityComponent) -> void:
	actor = parent.actor
	_parent = parent
	skill_res = skill
	stats_component = parent.stats_component
	attack_component = parent.attack_component
	death_component = parent.death_component
	hurtbox_component = parent.hurtbox_component
	stats_component.no_health.connect(explosive_finale)
	
	setup_area2d()
	setup_collision_shape()
	
func setup_area2d() -> void:

	add_child(explosive_finale_area2d)
	explosive_finale_area2d.add_child(explosive_finale_collision_shape)
	explosive_finale_area2d.set_collision_layer_value(1, false)
	
	if _parent.stats_component.enemy:
		explosive_finale_area2d.set_collision_mask_value(1, false)
		explosive_finale_area2d.set_collision_mask_value(2, true)
	else:
		explosive_finale_area2d.set_collision_mask_value(1, true)

func setup_collision_shape() -> void:
	explosive_finale_collision_shape.shape = circle
	circle.radius = explosive_finale_radius


func explosive_finale() -> void:
	#if we have current target when hero dies, we will shoot at them, else explosion where we die
	if hurtbox_component.last_hitter != null:
		global_position = hurtbox_component.last_hitter.global_position
	
	var possible_targets
	
	if stats_component.enemy:
		possible_targets = get_tree().get_nodes_in_group("team")
	else:
		possible_targets = get_tree().get_nodes_in_group("enemy")
	
	for enemy in possible_targets:
		if enemy.is_in_group("minion") or enemy.is_in_group("hero"):
			if enemy.global_position.distance_to(death_component.original_position) < explosive_finale_radius:
				for child in enemy.get_children():
					if child is HurtboxComponent:
						if child.has_method("take_damage"):
							child.take_damage(skill_res.damage + stats_component.damage, actor)
