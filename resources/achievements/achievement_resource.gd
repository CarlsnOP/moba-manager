extends Resource

class_name AchievementResource

enum REWARD_TYPE { XP, RUBBERDUCKS, LOOT, HP, HPREG, AD, AP, BLOCK, DODGE, CRIT, HERORUBBERDUCK, MOVESPEED, ATTSPEED}

@export_category("Settings")
@export var ach_index: int
@export var ach_title: String
@export var ach_1st_description: String
@export var ach_2nd_description: String
@export var ach_progress: int
@export var ach_current_step: int
@export var ach_completed: bool
@export var ach_requirement: Array[int]
@export var ach_completion_step: int = 0
@export var level := 0
@export var ach_reward_description: String
@export var multiplier: float = 1.0
@export var reward_type: REWARD_TYPE
@export var ach_reward_in_percentage: bool = true
@export var ach_reward_show_amount: bool = true
@export var ach_script: Script
