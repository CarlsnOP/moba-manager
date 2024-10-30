extends Node

var total_exp := 0
var exp_thresholds := []
var max_level := 100
var base_exp := 100
var exp_multiplier := 1.05

func _ready() -> void:
	generate_exp_thresholds()
	await get_tree().physics_frame
	update_hero_levels()

func generate_exp_thresholds():
	exp_thresholds.clear()
	var current_exp = 0

	for level in range(1, max_level + 1):
		current_exp += int(base_exp * pow(exp_multiplier, level - 1))
		exp_thresholds.append(current_exp)

func update_hero_levels() -> void:
	for hero in TeamManager._all_heroes:
		hero.lvl = 1
		
		for level in range(exp_thresholds.size()):
			if hero.xp < exp_thresholds[level]:
				hero.lvl = level + 1
				break
		if hero.xp >= exp_thresholds[-1]:
			hero.lvl = max_level
