extends Control


@onready var wave_label = %WaveLabel
@onready var spawn_timer = %SpawnTimer

@export var wave_spawn_timer := 15.0


func _ready():
	setup()

func _process(_delta):
	#wave_label.text = "Wave in: %02d" % time_till_next_wave()
	pass

func setup() -> void:
	spawn_timer.wait_time = wave_spawn_timer
	spawn_timer.start()
	
func time_till_next_wave() -> Array:
	var time_left = spawn_timer.time_left
	var second = int(time_left) % 60
	return [second]
