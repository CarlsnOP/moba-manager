class_name Minion
extends CharacterBody2D

const ENEMY_MINION = preload("res://assets/art/map/enemy_minion.png")
const FRIENDLY_MINION = preload("res://assets/art/map/friendly_minion.png")

@onready var stats_component = $StatsComponent
@onready var sprite_2d = $Sprite2D
@onready var navigation_component = $NavigationComponent

var friendly_minion_scale := Vector2(0.06, 0.06)

func setup(enemy: bool, top: bool) -> void:
	if enemy:
		stats_component.enemy = enemy
		sprite_2d.texture = ENEMY_MINION
	else:
		sprite_2d.texture = FRIENDLY_MINION
		sprite_2d.scale = friendly_minion_scale
	
	navigation_component.set_lane(top)
