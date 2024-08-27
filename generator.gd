extends Timer


func _ready():
	wait_time = GeneratorManager.tick_duration

func _on_timeout():
	GeneratorManager.generate_rubberduckies()
