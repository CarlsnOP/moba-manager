extends CharacterBody2D

enum ENEMY_STATE { DEFENSIVE, AGGRESSIVE, RETREATING }

@export_category("Stats:")
@export var _health := 200.0
@export var _damage := 75.0
@export var _ability_power := 30
@export var _move_speed := 90.0
@export var _att_speed := 1.0

@export_category("Lane:")
@export var lane_points: NodePath

@onready var health_bar = %HealthBar
@onready var att_timer = %AttTimer
@onready var ai_manager = %AiManager
@onready var nav_agent = $NavAgent
@onready var ai_data = %AiData
@onready var top_lane_bullies = %TopLaneBullies
@onready var bot_lane_bullies = %BotLaneBullies
@onready var top_lane_buddies = %TopLaneBuddies
@onready var bot_lane_buddies = %BotLaneBuddies

var _waypoints := []
var _current_wp := 0
var _state := ENEMY_STATE.AGGRESSIVE
var minions: Array[PathFollow2D] = []
var _furthest_minion: PathFollow2D = null
var nearest_structure = INF
var _target_loc: Vector2

func _ready():
	set_physics_process(false)
	await get_tree().physics_frame
	create_wp()
	
	top_lane_bullies.connect("child_entered_tree", Callable(self, "_on_minion_added"))
	top_lane_bullies.connect("child_exiting_tree", Callable(self, "_on_minion_removed"))
	call_deferred("late_setup")
	update_minions_list()

func late_setup():
	await get_tree().physics_frame
	call_deferred("set_physics_process", true )

func _physics_process(_delta):
	update_movement()
	update_navigation()

func _on_minion_added(child):
	if child is PathFollow2D:
		minions.append(child)

func _on_minion_removed(child):
	if child is PathFollow2D:
		minions.erase(child)

func update_minions_list() -> void:
	minions.clear()
	for child in top_lane_bullies.get_children():
		if child is PathFollow2D:
			minions.append(child)

func create_wp() -> void:
	_waypoints = ai_data.get_enemy_top_lane_data()

func update_navigation() -> void:
	if !nav_agent.is_navigation_finished():
		var next_path_position: Vector2 = nav_agent.get_next_path_position()
		
		if global_position.distance_to(next_path_position) > 5.0:
			velocity = global_position.direction_to(next_path_position) * _move_speed
			move_and_slide()

func process_push() -> void:
	get_all_minions()
	
	if minions.size() == 0:
		get_nearest_defence()
		nav_agent.target_position = _target_loc
	else:
		get_furthest_minion()
		nav_agent.target_position = _target_loc

func get_all_minions() -> void:
	for child in top_lane_bullies.get_children():
		if child is PathFollow2D:
			minions.append(child)

func get_furthest_minion() -> void:
	var max_progress = -1.0
	var valid_minions: Array[PathFollow2D] = []
	
	for minion in minions:
		if is_instance_valid(minion):
			valid_minions.append(minion)
	
	for minion in valid_minions:
		if minion.progress_ratio > max_progress:
			max_progress = minion.progress_ratio
			_target_loc = minion.global_position
	
	minions = valid_minions

func get_nearest_defence() -> Vector2:
	var structures = get_tree().get_nodes_in_group("bully")
	nearest_structure = INF
	
	for structure in structures:
		if structure.has_method("get_structure_position"):
			var structure_pos = structure.get_structure_position()
			var check_distance = global_position.distance_to(structure_pos)
			var nearest_distance = INF
			if check_distance < nearest_distance:
				nearest_distance = check_distance
				return structure_pos
	return Vector2(0, 0)
	
	
func update_movement() -> void:
	match _state:
		ENEMY_STATE.AGGRESSIVE:
			process_push()

func navigate_wp() -> void:
	if _current_wp >= len(_waypoints):
		_current_wp = 0
	nav_agent.target_position = _waypoints[_current_wp]
	_current_wp += 1
