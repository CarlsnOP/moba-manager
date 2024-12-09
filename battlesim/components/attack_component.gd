class_name AttackComponent
extends Node

signal hit_hurtbox(hurtbox)

@export var attack_timer: Timer
@export var Navigation_agent: NavigationAgent2D
@export var hitbox_component: HitboxComponent
@export var stats_component: StatsComponent

var current_target: Node2D = null
var current_target_hurtbox: Area2D = null

func _ready():
	hitbox_component.new_target_in_range.connect(new_target_in_range)
	hitbox_component.target_in_range_removed.connect(target_in_range_removed)
	attack_timer.timeout.connect(deal_damage)
	
	attack_timer.wait_time = stats_component.att_speed
	
func new_target_in_range(target: Area2D) -> void:
	if !target.get_parent() == current_target:
		return
	
	current_target_hurtbox = target
	attack_timer.start()
	
func target_in_range_removed(target: Area2D) -> void:
	if !target.get_parent() == current_target:
		return
	
	attack_timer.stop()

func deal_damage() -> void:
	if current_target_hurtbox.has_method("take_damage"):
		current_target_hurtbox.take_damage(stats_component.damage)
