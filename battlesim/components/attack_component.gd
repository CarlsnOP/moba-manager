class_name AttackComponent
extends Node

signal on_attack

@export var actor: PhysicsBody2D
@export var hitbox_component: HitboxComponent
@export var stats_component: StatsComponent
@export var movement_component: MoveComponent
@export var state_machine_component: StateMachineComponent
@export var detection_component: DetectionComponent

var current_target_hurtbox: HurtboxComponent = null
var attack_timer: Timer = Timer.new()

func _ready():
	setup_timer()

func _process(_delta):
	if current_target_hurtbox == null or \
	!current_target_hurtbox in hitbox_component.targets_in_range:
		attack_timer.stop()
	
	if actor is Hero:
		if !current_target_hurtbox in detection_component.detected_enemies and attack_timer.time_left > (attack_timer.wait_time / 2):
			attack_timer.stop()
			
	if current_target_hurtbox != null and attack_timer.is_stopped():
		if current_target_hurtbox in hitbox_component.targets_in_range:
			attack_timer.start()

	
	#The following logic is to make sure the units move as soon as no targets is in range
	if actor is Minion or actor is Hero:
		allow_movement()
	

func deal_damage() -> void:
	if is_instance_valid(current_target_hurtbox):
		if current_target_hurtbox.has_method("take_damage"):
			on_attack.emit()
			
			if actor is Tower or actor is Nexus:
				var projectile = ObjectMakerManager.create_projectile(
					actor.global_position,
					current_target_hurtbox.get_parent(),
					actor.actor_projectile)
				projectile.reached_target.connect(on_enemy_hit.unbind(1))
							
			else:
				on_enemy_hit()
				
	if current_target_hurtbox == null or !current_target_hurtbox in hitbox_component.targets_in_range:
		attack_timer.stop()

#State also calls this function, for example when closest ally dies
func allow_movement() -> void:
	if state_machine_component.current_state == DeadState:
		return
		
	elif !attack_timer.is_stopped():
		movement_component.immovable = true
		return

	movement_component.immovable = false

func on_enemy_hit() -> void:
	if is_instance_valid(current_target_hurtbox):
		current_target_hurtbox.take_damage(stats_component.damage, actor)

func setup_timer() -> void:
	add_child(attack_timer)
	attack_timer.timeout.connect(deal_damage)
	attack_timer.wait_time = stats_component.att_speed
	attack_timer.one_shot = false
	
