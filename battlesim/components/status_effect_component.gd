class_name StatusEffectComponent
extends HBoxContainer

const ICON_SIZE := 24
const ICON_ADJUSTMENT_SIZE := -12

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
var standard_pos := Vector2(-12, -70)

func _ready():
	child_order_changed.connect(adjust_position)
	position = standard_pos
	original_move_speed = stats_component.move_speed
	setup_timers()

func setup_timers() -> void:
	add_child(stunned_timer)
	stunned_timer.one_shot = true
	stunned_timer.timeout.connect(not_stunned)
	
	add_child(slowed_timer)
	slowed_timer.one_shot = true
	slowed_timer.timeout.connect(not_slowed)

func adjust_position() -> void:
	var temp_array := []
	for child in get_children():
		if child is TextureRect:
			temp_array.append(child)
			
	position.x = temp_array.size() * ICON_ADJUSTMENT_SIZE

func show_new_status_effect(tex: CompressedTexture2D) -> void:
	var new_texture := TextureRect.new()
	add_child(new_texture)
	new_texture.expand_mode = TextureRect.EXPAND_FIT_HEIGHT
	new_texture.custom_minimum_size.x = ICON_SIZE
	new_texture.texture = tex
	
func remove_new_status_effect(tex: CompressedTexture2D) -> void:
	for child in get_children():
		if child is TextureRect:
			if child.texture == tex:
				child.queue_free()

func handle_stun(duration: float) -> void:
	show_new_status_effect(DataStorage.STUNNED)
	attack_component.attack_timer.paused = true
	move_component.immovable = true
	stunned_timer.wait_time = duration
	is_stunned = true
	stunned_timer.start()
	
func not_stunned() -> void:
	remove_new_status_effect(DataStorage.STUNNED)
	attack_component.attack_timer.paused = false
	move_component.immovable = false
	is_stunned = false

func handle_slow(duration: float, slow_amount: float) -> void:
	show_new_status_effect(DataStorage.SLOWED)
	slowed_timer.wait_time = duration
	stats_component.move_speed = original_move_speed * (slow_multiplier - slow_amount)
	is_slowed = true
	slowed_timer.start()

func not_slowed() -> void:
	remove_new_status_effect(DataStorage.SLOWED)
	stats_component.move_speed = original_move_speed
	is_slowed = false
