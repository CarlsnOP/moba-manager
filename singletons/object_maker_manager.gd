extends Node


func create_projectile(start_pos: Vector2, last_hitter: PhysicsBody2D, proj_res: ProjectileResource) -> BaseProjectile:
	var new_projectile = DataStorage.BASE_PROJECTILE.instantiate() as BaseProjectile
	var temp_holder = get_tree().get_first_node_in_group("temp_scene_holder")
	temp_holder.add_child(new_projectile)
	new_projectile.setup(start_pos, last_hitter, proj_res)
	return new_projectile

func instantiate_particle_scene(start_pos: Vector2, scene: PackedScene) -> void:
	var new_particle = scene.instantiate()
	get_tree().get_first_node_in_group("temp_scene_holder").add_child(new_particle)
	new_particle.global_position = start_pos

func instantiate_scene(scene: PackedScene) -> void:
	var new_scene = scene.instantiate()
	get_tree().get_first_node_in_group("canvas").add_child(new_scene)
	
