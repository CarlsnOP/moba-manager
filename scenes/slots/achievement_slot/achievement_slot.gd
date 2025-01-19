extends Control

@onready var achievement_name_label = %AchievementNameLabel
@onready var description_label = %DescriptionLabel
@onready var reward_label = %RewardLabel
@onready var achieved_icon = %AchievedIcon
@onready var achieved_icon_2 = %AchievedIcon2
@onready var achieved_icon_3 = %AchievedIcon3
@onready var achieved_icon_4 = %AchievedIcon4
@onready var reward_amount_label = %RewardAmountLabel
@onready var next_reward_label = %NextRewardLabel
@onready var complete_achievement = %CompleteAchievement
@onready var get_reward_label = %GetRewardLabel

var achievement: AchievementResource

func setup(ach: AchievementResource) -> void:
	achievement = ach
	setup_label()
	setup_ducks()

func update() -> void:
	setup_label()
	setup_ducks()
	
func setup_label() -> void:
	get_reward_label.text = achievement.ach_reward_description + " " + str(achievement.ach_reward_growth)
	
	if achievement.ach_current_step > achievement.ach_accepted_rewards or achievement.ach_completed and achievement.ach_accepted_rewards < 4:
		complete_achievement.show()
		return
		
	achievement_name_label.text = achievement.ach_title
	reward_label.text = achievement.ach_reward_description
	if !achievement.ach_completed:
		description_label.text = " - " + achievement.ach_1st_description + " "
		description_label.text += str(achievement.ach_progress) + "/"
		description_label.text += str(achievement.ach_requirement[achievement.ach_current_step])
		description_label.text += " " + achievement.ach_2nd_description
		reward_amount_label.text = str(achievement.ach_current_step * achievement.ach_reward_growth) + " %"
		next_reward_label.text = " - Next: " + str((achievement.ach_current_step + 1) * achievement.ach_reward_growth) + " %"
	else:
		description_label.text = " - COMPLETED!"
		reward_amount_label.text = str(achievement.ach_current_step * achievement.ach_reward_growth) + " %"
		next_reward_label.hide()

func setup_ducks() -> void:
	if achievement.ach_current_step > 0:
		achieved_icon.texture = DataStorage.ACHIEVED_DUCK
	if achievement.ach_current_step > 1:
		achieved_icon_2.texture = DataStorage.ACHIEVED_DUCK
	if achievement.ach_current_step > 2:
		achieved_icon_3.texture = DataStorage.ACHIEVED_DUCK
	if achievement.ach_completed:
		achieved_icon_4.texture = DataStorage.ACHIEVED_DUCK


func _on_get_reward_button_pressed():
	achievement.ach_accepted_rewards += 1
	AchievementManager.update_achievement_stats(achievement)
	complete_achievement.hide()
	update()
