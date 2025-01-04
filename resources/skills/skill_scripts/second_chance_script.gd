class_name SecondChanceScript
extends Node2D

var cooldown_timer := Timer.new()
var _parent: AbilityComponent
var ally_death_component: DeathComponent

func setup_skill(skill: SkillResource, parent: AbilityComponent) -> void:
	_parent = parent
	setup_cooldown_timer(skill)
	setup()
	
func setup() -> void:
	var possible_allies := get_tree().get_nodes_in_group("hero")
	
	for ally in possible_allies:
		if _parent.stats_component.enemy:
			if ally.is_in_group("enemy"):
				if ally.has_method("get_stats_component"):
					var temp_stats_component = ally.get_stats_component() as StatsComponent
					temp_stats_component.no_health.connect(revive)
					for node in ally.get_children():
						if node is DeathComponent:
							ally_death_component = node
							
		else: 
			if ally.is_in_group("team"):
				if ally.has_method("get_stats_component"):
					var temp_stats_component = ally.get_stats_component() as StatsComponent
					temp_stats_component.no_health.connect(revive)
					for node in ally.get_children():
						if node is DeathComponent and node != _parent.death_component:
							ally_death_component = node

func setup_cooldown_timer(skill: SkillResource) -> void:
	call_deferred("add_child", cooldown_timer)
	
	cooldown_timer.wait_time = skill.cooldown
	cooldown_timer.one_shot = true

func revive() -> void:
	await get_tree().create_timer(0.5).timeout
	#check if ability is on cooldown
	if cooldown_timer.is_stopped() and \
	!_parent.state_machine_component.current_state is DeadState:
		ally_death_component.respawn()
		var ally_pos = ally_death_component.get_parent().global_position
		ObjectMakerManager.instantiate_particle_scene(global_position, DataStorage.SECOND_CHANCE_PARTICLES)
		ObjectMakerManager.instantiate_particle_scene(ally_pos, DataStorage.SECOND_CHANCE_PARTICLES)
		SoundManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.SKILL_SECOND_CHANCE_SFX)
		cooldown_timer.start()
