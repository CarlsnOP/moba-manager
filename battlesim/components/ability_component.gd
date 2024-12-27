class_name AbilityComponent
extends Node2D

@export var actor: PhysicsBody2D
@export var hitbox_component: HitboxComponent
@export var stats_component: StatsComponent
@export var state_machine_component: StateMachineComponent
@export var death_component: DeathComponent
@export var attack_component: AttackComponent

var ability_logic := Node2D.new()

func setup_ability(skill: SkillResource) -> void:
	call_deferred("add_child", ability_logic)
	
	await get_tree().create_timer(0.2).timeout
	
	ability_logic.set_script(skill.ability_script)

	
	if ability_logic.has_method("setup_skill"):
		ability_logic.setup_skill(skill, self)
	
	
