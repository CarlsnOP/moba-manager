extends State
class_name Defensive


var _self: CharacterBody2D
var nav_agent: NavigationAgent2D
var _move_speed: float
var _target_loc: Vector2
var _minions: Array[PathFollow2D]
var _tower_progress := 0.3


func enter(hero: CharacterBody2D, nav: NavigationAgent2D):
	_self = hero
	nav_agent = nav
	_move_speed = hero._move_speed

func exit():
	pass

func update(_delta: float):
	process_defensive()
	update_navigation()
	
func physics_update(_delta: float):
	pass

func update_navigation() -> void:
	if !nav_agent.is_navigation_finished():
		var next_path_position: Vector2 = nav_agent.get_next_path_position()
		
		if _self.global_position.distance_to(next_path_position) > 5.0:
			_self.velocity = _self.global_position.direction_to(next_path_position) * _move_speed
			_self.move_and_slide()

func process_defensive() -> void:
	_minions = _self.get_minion_array()
	
	if _minions.size() == 0:
		nav_agent.target_position = get_nearest_defence()
	else:
		get_furthest_minion()
		nav_agent.target_position = _target_loc

func get_furthest_minion() -> void:
	_minions = _self.get_minion_array()
	var max_progress = -1.0
	var valid_minions: Array[PathFollow2D] = []
	
	for minion in _minions:
		if is_instance_valid(minion):
			valid_minions.append(minion)
	
	for minion in valid_minions:
		if minion.progress_ratio > max_progress:
			max_progress = minion.progress_ratio
			
			if max_progress > _tower_progress:
				_target_loc = minion.global_position
			else:
				_target_loc = get_nearest_defence()
	
	_minions = valid_minions

func get_nearest_defence() -> Vector2:
	var structures = get_tree().get_nodes_in_group("bully_structure")
	var nearest_distance = INF
	var nearest_structure_pos = Vector2(0,0)
	
	
	for structure in structures:
		if structure.has_method("get_structure_position"):
			var structure_pos = structure.get_structure_position()
			var check_distance = _self.global_position.distance_to(structure_pos)
			
			if check_distance < nearest_distance:
				nearest_distance = check_distance
				nearest_structure_pos = structure_pos
				
	return nearest_structure_pos
