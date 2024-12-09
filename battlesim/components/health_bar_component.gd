class_name HealthBarComponent
extends ProgressBar


@export var stats_component: StatsComponent


func _ready():
	stats_component.health_changed.connect(update_health_bar)
	setup(stats_component.health, stats_component.health)
	
	
func setup(max_health: float, current_health: float) -> void:
	max_value = max_health
	value = current_health

func update_health_bar() -> void:
	value = stats_component.health
