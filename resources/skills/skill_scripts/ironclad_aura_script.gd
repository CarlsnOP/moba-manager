class_name IroncladAuraScript
extends Node2D

var _parent: AbilityComponent
var auraclad_aura_area2d := Area2D.new()
var auraclad_aura_collision_shape := CollisionShape2D.new()
var circle := CircleShape2D.new()
var auraclad_aura_radius := 150.0

var damage_reduction_modifier := 0.2

func setup_skill(_skill: SkillResource, parent: AbilityComponent) -> void:
	_parent = parent
	setup_area2d()
	setup_collision_shape()
	
func setup_area2d() -> void:

	add_child(auraclad_aura_area2d)
	auraclad_aura_area2d.add_child(auraclad_aura_collision_shape)
	auraclad_aura_area2d.area_entered.connect(area_entered)
	auraclad_aura_area2d.area_exited.connect(area_exited)
	auraclad_aura_area2d.set_collision_layer_value(1, false)
	
	if _parent.stats_component.enemy:
		auraclad_aura_area2d.set_collision_mask_value(1, false)
		auraclad_aura_area2d.set_collision_mask_value(2, true)
	else:
		auraclad_aura_area2d.set_collision_mask_value(1, true)

func setup_collision_shape() -> void:
	auraclad_aura_collision_shape.shape = circle
	circle.radius = auraclad_aura_radius

func area_entered(area) -> void:
	if area is HurtboxComponent:
		if area.get_parent() is Hero or area.get_parent() is Minion:
			var area_parent = area.get_parent()
			for child in area_parent.get_children():
				if child is StatsComponent:
					child.damage_reduction -= damage_reduction_modifier


func area_exited(area) -> void:
	if area is HurtboxComponent:
		if area.get_parent() is Hero or area.get_parent() is Minion:
			var area_parent = area.get_parent()
			for child in area_parent.get_children():
				if child is StatsComponent:
					child.damage_reduction += damage_reduction_modifier
