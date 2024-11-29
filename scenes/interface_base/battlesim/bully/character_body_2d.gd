extends CharacterBody2D

@onready var health_bar = %HealthBar
@onready var hit_flash_animation_player = %HitFlashAnimationPlayer



func take_damage(dmg: float, _attacker: Node2D) -> void:
	hit_flash_animation_player.play("flash")
	health_bar.take_damage(dmg)
	DamageNumbers.display_number(round(dmg), global_position, false)
