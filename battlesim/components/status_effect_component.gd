class_name StatusEffectComponent
extends Node

@export var attack_component: AttackComponent
@export var move_component: MoveComponent
@export var sprite: Sprite2D
@export var stats_component: StatsComponent

var slowed_timer := Timer.new()
var stunned_timer := Timer.new()
var is_stunned := false
var is_slowed := false
var original_move_speed: float
var slow_multiplier := 1

func _ready():
	original_move_speed = stats_component.move_speed
	setup_timers()

func setup_timers() -> void:
	add_child(stunned_timer)
	stunned_timer.one_shot = true
	stunned_timer.timeout.connect(not_stunned)
	
	add_child(slowed_timer)
	slowed_timer.one_shot = true
	slowed_timer.timeout.connect(not_slowed)

func handle_stun(duration: float) -> void:
	attack_component.attack_timer.paused = true
	move_component.immovable = true
	stunned_timer.wait_time = duration
	is_stunned = true
	stunned_timer.start()
	
func not_stunned() -> void:
	attack_component.attack_timer.paused = false
	move_component.immovable = false
	is_stunned = false

func handle_slow(duration: float, slow_amount: float) -> void:
	slowed_timer.wait_time = duration
	stats_component.move_speed = original_move_speed * (slow_multiplier - slow_amount)
	is_slowed = true
	slowed_timer.start()

func not_slowed() -> void:
	stats_component.move_speed = original_move_speed
	is_slowed = false
