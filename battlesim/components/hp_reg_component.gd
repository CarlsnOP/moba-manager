class_name HpRegComponent
extends Node

const HEALTH_REG_COOLDOWN := 1.0

@export var stats_component: StatsComponent

var timer := Timer.new()

func _ready():
	setup_timer()
	timer.start()
	
func setup_timer() -> void:
	add_child(timer)
	timer.timeout.connect(heal)
	timer.wait_time = HEALTH_REG_COOLDOWN
	timer.one_shot = false

func heal() -> void:
	stats_component.health += stats_component.health_regen
