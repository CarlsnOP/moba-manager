class_name FlashComponent
extends Node

const FLASH_MATERIAL = preload("res://effects/white_flash_material.tres")

@export var stats_component: StatsComponent
@export var sprite: Sprite2D
@export var flash_duration: = 0.2

var original_sprite_material: Material
var timer: Timer = Timer.new()


func _ready() -> void:
	add_child(timer)
	original_sprite_material = sprite.material
	stats_component.health_changed.connect(flash)

func flash():
	sprite.material = FLASH_MATERIAL
	timer.start(flash_duration)
	
	await timer.timeout
	
	sprite.material = original_sprite_material
