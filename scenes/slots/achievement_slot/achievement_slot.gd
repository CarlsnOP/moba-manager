extends Control

@onready var achievement_name_label = %AchievementNameLabel
@onready var description_label = %DescriptionLabel
@onready var reward_label = %RewardLabel
@onready var achieved_icon = %AchievedIcon
@onready var achieved_icon_2 = %AchievedIcon2
@onready var achieved_icon_3 = %AchievedIcon3
@onready var achieved_icon_4 = %AchievedIcon4
@onready var reward_amount_label = %RewardAmountLabel

var achievement: AchievementResource

func setup(ach: AchievementResource) -> void:
	achievement = ach
	setup_label()
	setup_ducks()
	
func setup_label() -> void:
	achievement_name_label.text = achievement.ach_title
	description_label.text = " - " + achievement.ach_1st_description + " "
	description_label.text += str(achievement.ach_requirement[achievement.ach_current_step])
	description_label.text += " " + achievement.ach_2nd_description
	reward_label.text = achievement.ach_reward_description
	reward_amount_label.text = str(achievement.ach_reward_base + (achievement.ach_current_step * achievement.ach_reward_growth)) + " %"

func setup_ducks() -> void:
	if achievement.ach_current_step > 0:
		achieved_icon.texture = DataStorage.ACHIEVED_DUCK
	if achievement.ach_current_step > 1:
		achieved_icon_2.texture = DataStorage.ACHIEVED_DUCK
	if achievement.ach_current_step > 2:
		achieved_icon_3.texture = DataStorage.ACHIEVED_DUCK
	if achievement.ach_current_step > 3:
		achieved_icon_4.texture = DataStorage.ACHIEVED_DUCK
