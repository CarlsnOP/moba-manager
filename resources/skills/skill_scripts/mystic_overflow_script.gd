class_name MysticOverflowScript
extends Node2D


var cooldown_timer := Timer.new()
var _parent: AbilityComponent
var hitbox_component: HitboxComponent
var attack_component: AttackComponent
var target: HurtboxComponent
var enemy_hurtbox: HurtboxComponent
var skill_res: SkillResource
var slow_duration := 2.0
var slow_amount := 0.2
var hero_resource: HeroResource

func setup_skill(skill: SkillResource, parent: AbilityComponent) -> void:
	set_process(true)
	_parent = parent
	hero_resource = _parent.actor.get_hero_resource() as HeroResource
	skill_res = skill
	hitbox_component = _parent.hitbox_component
	attack_component = _parent.attack_component
	
	setup_cooldown_timer(skill)


func setup_cooldown_timer(skill: SkillResource) -> void:
	call_deferred("add_child", cooldown_timer)
	
	cooldown_timer.wait_time = skill.cooldown
	cooldown_timer.one_shot = true
	cooldown_timer.autostart = true

func _process(_delta):
	if _parent.attack_component.current_target_hurtbox != null:
		enemy_hurtbox = _parent.attack_component.current_target_hurtbox
		
	if cooldown_timer.is_stopped() and is_instance_valid(enemy_hurtbox):
		if enemy_hurtbox.has_method("take_damage") and \
		enemy_hurtbox in _parent.hitbox_component.targets_in_range:
			
			enemy_hurtbox.take_damage(skill_res.damage + (hero_resource.ability_power / 2))
			var enemy = enemy_hurtbox.get_parent()
			cooldown_timer.start()
			
			for child in enemy.get_children():
				if child is StatusEffectComponent:
					var enemy_status_effect_component = child
					if enemy_status_effect_component.has_method("handle_slow"):
						enemy_status_effect_component.handle_slow(slow_duration, slow_amount)