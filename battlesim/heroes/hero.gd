class_name Hero
extends CharacterBody2D

@onready var hurtbox_component = $HurtboxComponent
@onready var stats_component = $StatsComponent
@onready var health_bar_component = $HealthBarComponent
@onready var sprite_2d = $Sprite2D
@onready var hitbox_component = $HitboxComponent
@onready var lane_manager_component = $LaneManagerComponent
@onready var navigation_component = $NavigationComponent
@onready var state_machine_component: StateMachineComponent = $StateMachineComponent
@onready var ability_component = $AbilityComponent

var _hero: HeroResource
var actor_name := "hero"
var stage_modifier := 1.0


func setup(hero: HeroResource, enemy: bool, top: bool, stage_mod: float) -> void:
	_hero = hero
	actor_name = hero.hero_name
	lane_manager_component.top_lane = top
	navigation_component.set_lane(top)
	
	
	if enemy:
		stats_component.enemy = enemy
		stage_modifier = stage_mod
		sprite_2d.texture = hero.hero_icon
		hurtbox_component.set_collision_layer_value(2, true)
		hitbox_component.set_collision_mask_value(1, true)
		ability_component.setup_ability(hero.skill)
		
	else:
		sprite_2d.texture = hero.hero_icon
		hurtbox_component.set_collision_layer_value(1, true)
		hitbox_component.set_collision_mask_value(2, true)
		ability_component.setup_ability(hero.skill)
		
	setup_hero_stats()


func setup_hero_stats() -> void:
	apply_stats()
	health_bar_component.update_max_health()

func apply_stats() -> void:
	for h in StatsManager.hero_specific_stats:
		if h["hero"] == _hero:
			stats_component.max_health = h["health"] * stage_modifier
			stats_component.health = h["health"] * stage_modifier
			stats_component.health_regen = h["health_reg"]
			stats_component.damage = h["damage"] * stage_modifier
			stats_component.ability_power = h["ability_power"]
			stats_component.dodge = h["dodge"]
			stats_component.block = h["block"]
			stats_component.crit = h["crit"]

func get_hurtbox() -> HurtboxComponent:
	return hurtbox_component

func get_stats_component() -> StatsComponent:
	return stats_component

func get_hero_resource() -> HeroResource:
	return _hero

func get_lane_manager_component() -> Node:
	return lane_manager_component

func get_state_machine_component() -> StateMachineComponent:
	return state_machine_component
