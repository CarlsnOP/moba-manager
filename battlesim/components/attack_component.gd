class_name AttackComponent
extends Node

@export var hitbox_component: HitboxComponent
@export var stats_component: StatsComponent

var current_target_hurtbox: HurtboxComponent = null
var attack_timer: Timer = Timer.new()

func _ready():
	add_child(attack_timer)
	attack_timer.timeout.connect(deal_damage)
	attack_timer.wait_time = stats_component.att_speed

func _process(_delta):
	if current_target_hurtbox != null and attack_timer.is_stopped():
		if current_target_hurtbox in hitbox_component.targets_in_range:
			attack_timer.start()

func deal_damage() -> void:
	if is_instance_valid(current_target_hurtbox):
		if current_target_hurtbox.has_method("take_damage") and current_target_hurtbox in hitbox_component.targets_in_range:
			current_target_hurtbox.take_damage(stats_component.damage)
		
		if current_target_hurtbox == null:
			attack_timer.stop()

	else:
		attack_timer.stop()
