class_name LootFinderScript
extends Node2D

var loot_reward_bonus := 0.1

func setup_skill(_skill: SkillResource, _parent: AbilityComponent) -> void:
	RewardManager._mod_luck += loot_reward_bonus
