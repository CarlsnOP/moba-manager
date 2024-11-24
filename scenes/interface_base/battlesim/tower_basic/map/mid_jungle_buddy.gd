extends Marker2D

@onready var respawn_timer_3 = %RespawnTimer3

func respawn_mob() -> void:
	respawn_timer_3.start()
