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
@onready var detection_component = $DetectionComponent
@onready var outline_component = $OutlineComponent
@onready var attack_component = $AttackComponent
@onready var hitbox_collision_shape = %HitboxCollisionShape
@onready var detection_collision_shape = %DetectionCollisionShape
@onready var controller_component = %ControllerComponent

var _hero: HeroResource
var actor_name := "hero"


func setup(hero: HeroResource, enemy: bool, top: bool, hero_stats: Array) -> void:
	_hero = hero
	actor_name = hero.hero_name
	lane_manager_component.top_lane = top
	navigation_component.set_lane(top)
	hitbox_collision_shape.shape = CircleShape2D.new()
	detection_collision_shape.shape = CircleShape2D.new()
	sprite_2d.texture = hero.hero_icon
	ability_component.setup_ability(hero.skill)
	
	if enemy:
		stats_component.enemy = enemy
		hurtbox_component.set_collision_layer_value(2, true)
		hitbox_component.set_collision_mask_value(1, true)
		detection_component.set_collision_mask_value(1, true)
		
	else:
		hurtbox_component.set_collision_layer_value(1, true)
		hitbox_component.set_collision_mask_value(2, true)
		detection_component.set_collision_mask_value(2, true)

		
	setup_hero_stats(hero_stats)


func setup_hero_stats(hero_stats: Array) -> void:
	apply_stats(hero_stats)
	health_bar_component.update_max_health()
	
	hitbox_collision_shape.shape.radius = stats_component.att_range
	detection_collision_shape.shape.radius = stats_component.att_range + 30

func apply_stats(hero_stats: Array) -> void:
	for h in hero_stats:
		if h["hero"] == _hero:
			stats_component.max_health = h["health"]
			stats_component.health = h["health"]
			stats_component.health_regen = h["health_reg"]
			stats_component.damage = h["damage"]
			stats_component.ability_power = h["ability_power"]
			stats_component.dodge = h["dodge"]
			stats_component.block = h["block"]
			stats_component.crit = h["crit"]
			stats_component.move_speed = h["move_speed"]
			stats_component.att_range = h["att_range"]
			stats_component.att_speed= h["att_speed"]

func get_controller_component() -> ControllerComponent:
	return controller_component

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
	
func get_outline_component() -> OutlineComponent:
	return outline_component
	
func get_attack_component() -> AttackComponent:
	return attack_component
	
