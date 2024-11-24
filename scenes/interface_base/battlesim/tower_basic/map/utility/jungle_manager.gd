extends Node


const JUNGLE_MOB = preload("res://scenes/interface_base/battlesim/jungle_basic/jungle_juggernaut.tscn")


@onready var top_jungle_bully = %TopJungleBully
@onready var mid_jungle_bully = %MidJungleBully
@onready var mid_jungle_buddy = %MidJungleBuddy
@onready var bot_jungle_buddy = %BotJungleBuddy

var jungle := []

#func _ready():
	#spawn_jungle()

func spawn_jungle() -> void:
	jungle.append(top_jungle_bully)
	jungle.append(mid_jungle_bully)
	jungle.append(mid_jungle_buddy)
	jungle.append(bot_jungle_buddy)
	for mobs in jungle:
		var new_mob = JUNGLE_MOB.instantiate()
		mobs.add_child(new_mob)
		
func get_jungle() -> Array:
	return jungle

func _on_respawn_timer_1_timeout():
	var new_mob = JUNGLE_MOB.instantiate()
	top_jungle_bully.add_child(new_mob)
	SignalManager.on_jungle_respawn_enemy.emit()

func _on_respawn_timer_2_timeout():
	var new_mob = JUNGLE_MOB.instantiate()
	mid_jungle_bully.add_child(new_mob)
	SignalManager.on_jungle_respawn_enemy.emit()

func _on_respawn_timer_3_timeout():
	var new_mob = JUNGLE_MOB.instantiate()
	mid_jungle_buddy.add_child(new_mob)
	SignalManager.on_jungle_respawn_team.emit()

func _on_respawn_timer_4_timeout():
	var new_mob = JUNGLE_MOB.instantiate()
	bot_jungle_buddy.add_child(new_mob)
	SignalManager.on_jungle_respawn_team.emit()
