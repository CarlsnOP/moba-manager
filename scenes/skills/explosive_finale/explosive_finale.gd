extends Node


var grenade_damage: float
var blast_damage: float
var explosion_radius := 100.0

func _ready() -> void:
	SignalManager.friendly_hero_died.connect(friendly_hero_died)
	grenade_damage = get_parent()._damage
	blast_damage = grenade_damage / 2


func friendly_hero_died(hero: HeroResource, node: Node2D, _pos: Vector2) -> void:
	if hero == get_parent().get_res():
		var hero_killer = node._attacker
		hero_killer.take_damage(grenade_damage, node)
		var rng_value = randf()  
		
		if rng_value < 0.5:
			create_explosion(hero_killer.global_position, node)
		else:
			return

func create_explosion(center: Vector2, node: Node2D) -> void:
	for enemy in get_tree().get_nodes_in_group("bully"):
		if enemy.global_position.distance_to(center) <= explosion_radius:
			if enemy.has_method("take_damage"):
				enemy.take_damage(blast_damage, node)
