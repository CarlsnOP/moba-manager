class_name IroncladAuraScript
extends Node2D

#Sprite 100x100 px
const SPRITE_SCALE := Vector2(1.5, 1.5)

var _parent: AbilityComponent
var auraclad_aura_area2d := Area2D.new()
var auraclad_aura_collision_shape := CollisionShape2D.new()
var circle := CircleShape2D.new()
var circle_sprite := Sprite2D.new()
var auraclad_aura_radius := 150.0

var damage_reduction_modifier := 0.2

func setup_skill(_skill: SkillResource, parent: AbilityComponent) -> void:
	_parent = parent
	setup_area2d()
	setup_collision_shape()
	setup_sprite()
	
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

func setup_sprite() -> void:
	circle_sprite.texture = DataStorage.IRONCLAD_AURA_RANGE
	circle_sprite.scale = SPRITE_SCALE
	add_child(circle_sprite)

func area_entered(area) -> void:
	if area is HurtboxComponent:
		if area.get_parent() is Hero or area.get_parent() is Minion:
			var area_parent = area.get_parent()
			for child in area_parent.get_children():
				if child is StatsComponent:
					child.damage_reduction -= damage_reduction_modifier
					
				if child is StatusEffectComponent:
					child.show_new_status_effect(DataStorage.IRONCLAD_AURA)
					SoundManager.create_2d_audio_at_location(child.global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.SKILL_IRONCLAD_AURA_ON_SFX)


func area_exited(area) -> void:
	if area is HurtboxComponent:
		if area.get_parent() is Hero or area.get_parent() is Minion:
			var area_parent = area.get_parent()
			for child in area_parent.get_children():
				if child is StatsComponent:
					child.damage_reduction += damage_reduction_modifier
				
				if child is StatusEffectComponent:
					child.remove_new_status_effect(DataStorage.IRONCLAD_AURA)
					SoundManager.create_2d_audio_at_location(child.global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.SKILL_IRONCLAD_AURA_OFF_SFX)
