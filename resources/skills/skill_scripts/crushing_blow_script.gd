class_name CrushingBlowScript
extends Node2D

var cooldown_timer := Timer.new()
var _parent: AbilityComponent
var skill_res: SkillResource
var enemy_hurtbox: HurtboxComponent
var stun_duration := 1.0


func setup_skill(skill: SkillResource, parent: AbilityComponent) -> void:
	_parent = parent
	skill_res = skill
	setup_cooldown_timer(skill)
	setup()

func setup() -> void:
	_parent.attack_component.attack_timer.timeout.connect(crushing_blow)
	
func setup_cooldown_timer(skill: SkillResource) -> void:
	call_deferred("add_child", cooldown_timer)
	
	cooldown_timer.wait_time = skill.cooldown
	cooldown_timer.one_shot = true

func crushing_blow() -> void:
	enemy_hurtbox = _parent.attack_component.current_target_hurtbox
	if cooldown_timer.is_stopped() and is_instance_valid(enemy_hurtbox):
		if enemy_hurtbox.has_method("take_damage") and \
		enemy_hurtbox in _parent.hitbox_component.targets_in_range:
			enemy_hurtbox.take_damage(_parent.stats_component.damage * skill_res.damage, _parent.get_parent())
			SoundManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.CRUSHING_BLOW_HIT)
			var enemy = enemy_hurtbox.get_parent()
			ObjectMakerManager.instantiate_particle_scene(enemy.global_position, DataStorage.CRUSHING_BLOW_PARTICLES)

			
			for child in enemy.get_children():
				if child is StatusEffectComponent:
					var enemy_status_effect_component = child
					if enemy_status_effect_component.has_method("handle_stun"):
						enemy_status_effect_component.handle_stun(stun_duration)
						
			cooldown_timer.start()
