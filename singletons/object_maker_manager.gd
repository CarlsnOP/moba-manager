extends Node

const BASE_PROJECTILE = preload("res://battlesim/projectiles/base_projectile/base_projectile.tscn")
const BASE_EXPLOSION = preload("res://battlesim/effects/explosion/base_explosion.tscn")

func create_projectile(start_pos: Vector2, end_pos: Vector2, proj_res: ProjectileResource, actor: Node2D) -> void:
	var new_projectile = BASE_PROJECTILE.instantiate() as BaseProjectile
	actor.add_child(new_projectile)
	new_projectile.setup(start_pos, end_pos, proj_res)

func create_explosion(start_pos: Vector2) -> void:
	var new_explosion = BASE_EXPLOSION.instantiate() as BaseExplosion
	get_tree().get_first_node_in_group("temp_scene_holder").add_child(new_explosion)
	new_explosion.setup(start_pos)
