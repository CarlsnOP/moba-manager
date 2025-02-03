class_name AttackComponent
extends Node

signal on_attack

@export var actor: PhysicsBody2D
@export var hitbox_component: HitboxComponent
@export var stats_component: StatsComponent
@export var movement_component: MoveComponent
@export var state_machine_component: StateMachineComponent

var current_target_hurtbox: HurtboxComponent = null
var attack_timer: Timer = Timer.new()

func _ready():
	setup_timer()

func _process(_delta):
	if current_target_hurtbox == null or !current_target_hurtbox in hitbox_component.targets_in_range:
		attack_timer.stop()
	
	if current_target_hurtbox != null and attack_timer.is_stopped():
		if current_target_hurtbox in hitbox_component.targets_in_range:
			attack_timer.start()
			current_target_hurtbox = current_target_hurtbox

	
	#The following logic is to make sure the units move as soon as no targets is in range
	if actor is Minion or actor is Hero:
		allow_movement()
	

func deal_damage() -> void:
	if is_instance_valid(current_target_hurtbox):
		if current_target_hurtbox.has_method("take_damage") and \
		current_target_hurtbox in hitbox_component.targets_in_range:
			on_attack.emit()
			
			if actor is Tower or actor is Nexus:
				var projectile = ObjectMakerManager.create_projectile(
					actor.global_position,
					current_target_hurtbox.get_parent(),
					actor.actor_projectile)
				projectile.reached_target.connect(on_enemy_hit.unbind(1))
							
			else:
				on_enemy_hit()

	attack_timer.stop()

#State also calls this function, for example when closest ally dies
func allow_movement() -> void:
	if !attack_timer.is_stopped():
		movement_component.immovable = true
		return

	elif state_machine_component.current_state == DeadState:
		return
		
	else:
		movement_component.immovable = false

func on_enemy_hit() -> void:
	if is_instance_valid(current_target_hurtbox):
		current_target_hurtbox.take_damage(stats_component.damage, actor)

func setup_timer() -> void:
	add_child(attack_timer)
	attack_timer.timeout.connect(deal_damage)
	attack_timer.wait_time = stats_component.att_speed
	attack_timer.one_shot = true
	
