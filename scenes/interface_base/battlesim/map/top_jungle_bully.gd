extends Marker2D

@onready var respawn_timer_1 = %RespawnTimer1

func respawn_mob() -> void:
	respawn_timer_1.start()
