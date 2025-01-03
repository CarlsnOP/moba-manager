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


func setup(hero: HeroResource, enemy: bool, top: bool) -> void:
	_hero = hero
	actor_name = hero.hero_name
	lane_manager_component.top_lane = top
	navigation_component.set_lane(top)
	
	if enemy:
		stats_component.enemy = enemy
		
		sprite_2d.texture = hero.hero_icon
		hurtbox_component.set_collision_layer_value(2, true)
		hitbox_component.set_collision_mask_value(1, true)
		
	else:
		sprite_2d.texture = hero.hero_icon
		hurtbox_component.set_collision_layer_value(1, true)
		hitbox_component.set_collision_mask_value(2, true)
		ability_component.setup_ability(hero.skill)
		
	setup_hero_stats()


func setup_hero_stats() -> void:
	apply_stats()
	
	if _hero.equipped_equipment != null:
		apply_equipment_bonus()
			
	
	health_bar_component.update_max_health()

func apply_stats() -> void:
	stats_component.max_health = (_hero.health + (_hero.lvl * _hero.extra_hp))
	stats_component.health = (_hero.health + (_hero.lvl * _hero.extra_hp))
	stats_component.health_regen = (_hero.health_regen)
	stats_component.damage = (_hero.attack_damage + (_hero.lvl * _hero.extra_ad))
	stats_component.ability_power = (_hero.ability_power + (_hero.lvl * _hero.extra_ap))
	stats_component.dodge = _hero.dodge
	stats_component.block = _hero.block
	stats_component.crit = _hero.crit

func apply_equipment_bonus() -> void:
	stats_component.max_health *= _hero.equipped_equipment.item_hp
	stats_component.health *= _hero.equipped_equipment.item_hp
	stats_component.health_regen *= _hero.equipped_item.equipment_hp_regen
	stats_component.damage *= _hero.equipped_equipment.item_ad
	stats_component.ability_power *= _hero.equipped_equipment.item_ap
	stats_component.dodge += _hero.equipped_item.item_dodge
	stats_component.block += _hero.equipped_item.item_block
	stats_component.crit += _hero.equipped_item.item_crit

func apply_match_modifier(modifier: float) -> void:
	stats_component.max_health *= modifier
	stats_component.health *= modifier
	stats_component.damage *= modifier
	health_bar_component.update_max_health()

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
