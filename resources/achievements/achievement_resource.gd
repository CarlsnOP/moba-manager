extends Resource

class_name AchievementResource

@export_category("Settings")
@export var ach_index: int
@export var ach_title: String
@export var ach_1st_description: String
@export var ach_2nd_description: String
@export var ach_current_step: int
@export var ach_requirement: Array[int]
@export var ach_completion_step: int = 0
@export var ach_reward_description: String
@export var ach_reward_base: int
@export var ach_reward_growth: int
