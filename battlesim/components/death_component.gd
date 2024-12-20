class_name DeathComponent
extends Node

const MINIMUM_RESPAWN_TIME := 20.0

@export var actor: Node2D
@export var stats_component: StatsComponent
@export var lane_manager_component: LaneManagerComponent

var dead_pos = Vector2(-20, -20)
var respawn_timer: Timer = Timer.new()

func _ready():
	if actor is Hero:
		add_child(respawn_timer)
		respawn_timer.one_shot = true
	stats_component.no_health.connect(process_death)
	respawn_timer.timeout.connect(respawn)


func process_death() -> void:
	if actor is Nexus:
		SignalManager.on_battle_end.emit(stats_component.enemy)
		
	elif !actor is Hero:
		actor.queue_free()
		
	else:
		actor.global_position = dead_pos
		var match_elapsed_time = get_tree().get_first_node_in_group("map") as Map
		respawn_timer.wait_time = MINIMUM_RESPAWN_TIME + (match_elapsed_time.get_game_length() * 0.1)
		respawn_timer.start()

func respawn() -> void:
	if stats_component.enemy:
		actor.global_position = lane_manager_component.enemy_nexus.global_position
	else:
		actor.global_position = lane_manager_component.friendly_nexus.global_position
		
	stats_component.health = stats_component.max_health
	#state_machine.on_respawn()
