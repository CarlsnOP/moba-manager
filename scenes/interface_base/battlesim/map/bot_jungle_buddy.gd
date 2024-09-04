extends Marker2D

@onready var respawn_timer_4 = %RespawnTimer4

func respawn_mob() -> void:
	respawn_timer_4.start()
