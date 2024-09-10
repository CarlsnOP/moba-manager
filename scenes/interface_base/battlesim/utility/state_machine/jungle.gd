extends State
class_name Jungle



var _self: CharacterBody2D
var nav_agent: NavigationAgent2D
var _team: int
var _move_speed: float
var jungle_camps: Array
var jungle_manager
var _target_loc: Vector2
var top_camp_enemy: Node2D
var mid_camp_enemy: Node2D
var mid_camp_team: Node2D
var bot_camp_team: Node2D

func enter(hero: CharacterBody2D, nav: NavigationAgent2D):
	_self = hero
	nav_agent = nav
	_move_speed = hero._move_speed
	_team = hero._team
	await get_tree().create_timer(1.0).timeout
	jungle_camps = hero.get_jungle_array()
	top_camp_enemy = jungle_camps[0]
	mid_camp_enemy = jungle_camps[1]
	mid_camp_team = jungle_camps[2]
	bot_camp_team = jungle_camps[3]
	
func exit():
	pass

func update(_delta: float):
	if _team == 0:
		process_jungle_team()
		update_navigation()
	
	if _team == 1:
		process_jungle_enemy()
		update_navigation()
	
func physics_update(_delta: float):
	pass
	
func update_navigation() -> void:
	if !nav_agent.is_navigation_finished():
		var next_path_position: Vector2 = nav_agent.get_next_path_position()
		
		if _self.global_position.distance_to(next_path_position) > 5.0:
			_self.velocity = _self.global_position.direction_to(next_path_position) * _move_speed
			_self.move_and_slide()

func process_jungle_team() -> void:
	pass

func process_jungle_enemy() -> void:
	if jungle_camps.size() > 0:
		if top_camp_enemy.get_children().size() > 1:
			_target_loc = top_camp_enemy.global_position
			nav_agent.target_position = _target_loc
		elif mid_camp_enemy.get_children().size() > 1:
			_target_loc = mid_camp_enemy.global_position
			nav_agent.target_position = _target_loc
		else:
			on_child_transition.emit(self, "Defensive")
			SignalManager.on_jungle_clear.emit(JungleLane, "BotLaneEnemy")
	
