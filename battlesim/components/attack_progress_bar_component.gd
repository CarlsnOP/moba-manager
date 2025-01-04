class_name AttackProgressBarComponent
extends TextureProgressBar

@export var attack_component: AttackComponent
@export var hitbox_component: HitboxComponent

func _ready():
	await get_tree().physics_frame
	max_value = attack_component.attack_timer.wait_time

func _process(_delta):
	if attack_component.attack_timer.is_stopped() or hitbox_component.targets_in_range.size() <= 0:
		hide()
	else:
		show()
		value = max_value - attack_component.attack_timer.time_left
