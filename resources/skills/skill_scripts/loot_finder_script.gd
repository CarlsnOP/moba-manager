class_name LootFinderScript
extends Node2D

var loot_reward_bonus := 0.1

func setup_skill(_skill: SkillResource, _parent: AbilityComponent) -> void:
	RewardManager._mod_luck += loot_reward_bonus
	SoundManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.SKILL_LOOT_FINDER_SFX)
