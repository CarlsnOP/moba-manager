extends ProgressBar


@onready var generator = $Generator


func _ready():
	generator.wait_time = value



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	value = generator.time_left
