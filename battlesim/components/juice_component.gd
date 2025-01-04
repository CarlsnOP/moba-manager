class_name JuiceComponent
extends Node2D

@export var actor: PhysicsBody2D
@export var attack_component: AttackComponent
@export var move_component: MoveComponent
@export var death_component: DeathComponent


func _ready():
	attack_component.on_attack.connect(on_attack)
	death_component.on_death.connect(on_death)
	
	for child in actor.get_children():
		if child is NexusHealingComponent:
			child.on_heal.connect(on_heal)

func _process(_delta):
	if actor is CharacterBody2D:
		if !move_component.standing_still:
			SoundManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.WALK_SFX)

func on_attack() -> void:
	if actor is Tower:
		SoundManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.TOWER_AUTOATTACK_SFX)
	
	if actor is Nexus:
		SoundManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.NEXUS_AUTOATTACK_SFX)
	
	if actor is Minion:
		SoundManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.SWORD_HIT_SFX)
	
	if actor is Hero:
		var hero_res = actor.get_hero_resource() as HeroResource
		SoundManager.create_2d_audio_at_location(global_position, hero_res.hero_autoattack_sfx)

func on_death() -> void:
	ObjectMakerManager.instantiate_particle_scene(actor.global_position, DataStorage.DEATH_PARTICLES)
	if actor is Minion or actor is Hero:
		SoundManager.create_2d_audio_at_location(actor.global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.UNIT_DIE_SFX)
	
	elif actor is Tower or actor is Nexus:
		SoundManager.create_2d_audio_at_location(actor.global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.BUILDING_DESTOYED_SFX)

func on_heal(pos: Vector2) -> void:
	SoundManager.create_2d_audio_at_location(pos, SoundEffectSettings.SOUND_EFFECT_TYPE.NEXUS_HEAL_SFX)
	ObjectMakerManager.instantiate_particle_scene(pos, DataStorage.HEALING_PARTICLES)
