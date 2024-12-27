class_name AttackComponent
extends Node

@export var actor: PhysicsBody2D
@export var hitbox_component: HitboxComponent
@export var stats_component: StatsComponent
@export var movement_component: MoveComponent
@export var state_machine_component: StateMachineComponent
@export var immovable_time := 0.2

var current_target_hurtbox: HurtboxComponent = null
var attack_timer: Timer = Timer.new()
var immovable_timer: Timer = Timer.new()

func _ready():
	setup_timers()

func _process(_delta):
	if current_target_hurtbox != null and attack_timer.is_stopped():
		if current_target_hurtbox in hitbox_component.targets_in_range:
			attack_timer.start()

func setup_timers() -> void:
	add_child(attack_timer)
	attack_timer.timeout.connect(deal_damage)
	attack_timer.wait_time = stats_component.att_speed
	
	await get_tree().physics_frame
	if actor.is_in_group("hero"):
		add_child(immovable_timer)
		immovable_timer.timeout.connect(allow_movement)
		immovable_timer.wait_time = immovable_time
		immovable_timer.one_shot = true

func deal_damage() -> void:
	if is_instance_valid(current_target_hurtbox):
		if current_target_hurtbox.has_method("take_damage") and \
		current_target_hurtbox in hitbox_component.targets_in_range:
			current_target_hurtbox.take_damage(stats_component.damage, actor)
			
			if actor.is_in_group("hero"):
				movement_component.immovable = true
				immovable_timer.start()
		
		if current_target_hurtbox == null:
			attack_timer.stop()

	else:
		attack_timer.stop()

func allow_movement() -> void:
	if state_machine_component.current_state != DeadState:
		movement_component.immovable = false
