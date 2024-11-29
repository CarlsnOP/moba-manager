extends CharacterBody2D

@onready var health_bar = %HealthBar
@onready var hit_flash_animation_player = %HitFlashAnimationPlayer


var _damage_reduction := 1.0

func take_damage(dmg: float, _attacker: Node2D) -> void:
	hit_flash_animation_player.play("flash")
	health_bar.take_damage(dmg * _damage_reduction)
	DamageNumbers.display_number(round(dmg), global_position, false)
	
func set_dmg_red(dmg_red: float) -> void:
	_damage_reduction += dmg_red
