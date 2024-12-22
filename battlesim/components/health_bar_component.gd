class_name HealthBarComponent
extends ProgressBar

signal health_bar_updated

@export var stats_component: StatsComponent

var healthbar_minimum_size := Vector2(70, 7)
var healthbar_position := Vector2(-32, -40)

func _ready():
	stats_component.health_changed.connect(update_health_bar)
	setup_settings()
	setup(stats_component.health, stats_component.health)

func setup_settings() -> void:
	show_percentage = false
	custom_minimum_size = healthbar_minimum_size
	size = healthbar_minimum_size
	position = healthbar_position

func setup(max_health: float, current_health: float) -> void:
	max_value = max_health
	value = current_health

func update_max_health() -> void:
	max_value = stats_component.max_health
	value = stats_component.max_health

func update_health_bar() -> void:
	value = stats_component.health
