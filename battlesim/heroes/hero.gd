extends CharacterBody2D

@onready var hurtbox_component = $HurtboxComponent
@onready var stats_component = $StatsComponent
@onready var health_bar_component = $HealthBarComponent
@onready var sprite_2d = $Sprite2D
@onready var hitbox_component = $HitboxComponent

var _hero: HeroResource

func setup(hero: HeroResource, enemy: bool) -> void:
	_hero = hero
	
	match hero:
		TeamManager.top:
			print("top")
		TeamManager.bot:
			print("bot")
			
	if enemy:
		stats_component.enemy = enemy
		
		sprite_2d.texture = hero.hero_icon
		hurtbox_component.set_collision_layer_value(2, true)
		hitbox_component.set_collision_mask_value(1, true)
	else:
		sprite_2d.texture = hero.hero_icon
		hurtbox_component.set_collision_layer_value(1, true)
		hitbox_component.set_collision_mask_value(2, true)
	setup_hero_stats()

func setup_hero_stats() -> void:
	apply_stats()
	
	if _hero is FriendlyHeroResource:
		if _hero.equipped_item != null:
			stats_component.health = (_hero.health + (_hero.lvl * _hero.extra_hp)) * _hero.equipped_item.item_hp
			stats_component.health_regen = (_hero.health_regen) * _hero.equipped_item.item_hp_regen
			stats_component.damage = (_hero.attack_damage + (_hero.lvl * _hero.extra_ad)) * _hero.equipped_item.item_ad
			stats_component.ability_power = (_hero.ability_power + (_hero.lvl * _hero.extra_ap)) * _hero.equipped_item.item_ap
			stats_component.dodge = _hero.dodge + _hero.equipped_item.item_dodge
			stats_component.block = _hero.block + _hero.equipped_item.item_block
			stats_component.crit = _hero.crit + _hero.equipped_item.item_crit
		else:
			stats_component.health = _hero.health + (_hero.lvl * _hero.extra_hp)
			stats_component.damage = _hero.attack_damage + (_hero.lvl * _hero.extra_ad)
			stats_component.ability_power = _hero.ability_power + (_hero.lvl * _hero.extra_ap)

func apply_stats() -> void:
	stats_component.health = _hero.health
	stats_component.health_regen = _hero.health_regen
	stats_component.damage = _hero.attack_damage
	stats_component.ability_power = _hero.ability_power
	stats_component.dodge = _hero.dodge
	stats_component.block = _hero.block
	stats_component.crit = _hero.crit

func apply_match_modifier(modifier: float) -> void:
	stats_component.health = stats_component.health * modifier
	stats_component.damage = stats_component.damage * modifier
	health_bar_component.update_max_health(stats_component.health * modifier)

func get_hurtbox() -> HurtboxComponent:
	return hurtbox_component
