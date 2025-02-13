class_name Tower
extends StaticBody2D

const ENEMY_TOWER = preload("res://assets/art/map/enemy_tower.png")
const FRIENDLY_TOWER = preload("res://assets/art/map/friendly_tower.png")

@onready var stats_component = $StatsComponent
@onready var sprite_2d = $Sprite2D
@onready var hurtbox_component = $HurtboxComponent
@onready var hitbox_component = $HitboxComponent
@onready var clickable_component = %ClickableComponent

@export var actor_projectile: ProjectileResource

var scale_adjustment := Vector2(0.15, 0.15)
var actor_name := "Tower"

func setup(enemy: bool) -> void:
	#Apply to enemy towers
	if enemy:
		stats_component.enemy = enemy
		sprite_2d.texture = ENEMY_TOWER
		hurtbox_component.set_collision_layer_value(2, true)
		hitbox_component.set_collision_mask_value(1, true)
		
	
	#Apply to firendly towers
	else:
		sprite_2d.texture = FRIENDLY_TOWER
		sprite_2d.scale = scale_adjustment
		hurtbox_component.set_collision_layer_value(1, true)
		hitbox_component.set_collision_mask_value(2, true)
		
	clickable_component.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

func get_hurtbox() -> HurtboxComponent:
	return hurtbox_component
