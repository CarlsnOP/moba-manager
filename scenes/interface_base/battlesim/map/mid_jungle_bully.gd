extends Marker2D

@onready var respawn_timer_2 = %RespawnTimer2

func respawn_mob() -> void:
	respawn_timer_2.start()
