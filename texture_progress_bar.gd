extends TextureProgressBar


signal died


@export var level_low := 30
@export var level_med := 65

const COLOR_DANGER := Color("#cc0000")
const COLOR_MIDDLE := Color("#FF9900")
const COLOR_GOOD := Color("#33cc33")

func setup(max_health: float, current_health: float) -> void:
	max_value = max_health
	value = current_health
	set_color()

func set_color() -> void:
	if value < level_low:
		tint_progress = COLOR_DANGER
	elif value < level_med:
		tint_progress = COLOR_MIDDLE
	else:
		tint_progress = COLOR_GOOD

func incr_value(v: int) -> void:
	value += v
	if value <= 0:
		died.emit()
	set_color()

func take_damage(v: int) -> void:
	incr_value(-v)
