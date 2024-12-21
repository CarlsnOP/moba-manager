class_name DamageNumbersComponent
extends Node


@export var actor: PhysicsBody2D
@export var hurtbox_Component: HurtboxComponent


func _ready() -> void:
	hurtbox_Component.hurt.connect(display_damage_number)
	
func display_damage_number(damage: int) -> void:
	var number = Label.new()
	number.global_position = actor.global_position
	number.position.y -= 50
	number.text = str(damage)
	number.label_settings = LabelSettings.new()

	var color = "#FFF"

	number.label_settings.font_color = color
	number.label_settings.font_size = 18
	number.label_settings.outline_color = "#000"
	number.label_settings.outline_size = 1

	call_deferred("add_child", number)
	
	await number.resized
	var rand_x = randi_range(-1, 1)
	var rand_y = randi_range(-1, 0)
	number.pivot_offset = Vector2(number.size / 2)
	number.position.x -= number.size.x/2
	
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		number, "position", number.position + Vector2((rand_x * 24), (rand_y * 24)), 0.25
	).set_ease(tween.EASE_OUT)
	tween.tween_property(
		number, "position:y", number.position.y, 0.5
	).set_ease(Tween.EASE_IN).set_delay(0.25)
	tween.tween_property(
		number, "scale", Vector2.ZERO, 0.25
	).set_ease(Tween.EASE_IN).set_delay(0.5)
	
	#Binds tween to node, so no errors happen if parent node is queued_free
	tween.bind_node(self)
	
	await tween.finished
	number.queue_free()