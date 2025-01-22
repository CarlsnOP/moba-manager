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
	get_reward_label.text = achievement.ach_reward_description
	achievement_name_label.text = achievement.ach_title
	reward_label.text = achievement.ach_reward_description
	description_label.text = " - " + achievement.ach_1st_description + " "
	
	if achievement.ach_reward_show_amount:
		get_reward_label.text += " " + str(achievement.ach_reward_growth)
	
	if achievement.ach_current_step > achievement.ach_accepted_rewards or achievement.ach_completed and achievement.ach_accepted_rewards < achievement.ach_requirement.size():
		complete_achievement.show()
		var parent_node = get_parent()
		parent_node.move_child(self, 0)
		return
		

	if !achievement.ach_completed:
		description_label.text += str(achievement.ach_progress) + "/"
		description_label.text += str(achievement.ach_requirement[achievement.ach_current_step])
		description_label.text += " " + achievement.ach_2nd_description
		if achievement.ach_reward_show_amount:
			reward_amount_label.text = str(achievement.ach_accepted_rewards * achievement.ach_reward_growth)
			next_reward_label.text = " - Next: " + str((achievement.ach_current_step + 1) * achievement.ach_reward_growth)
		
		if achievement.ach_reward_in_percentage:
			reward_amount_label.text +=  " %"
			next_reward_label.text += " %"
	else:
		description_label.text = " - COMPLETED!"
		if achievement.ach_reward_show_amount:
			reward_amount_label.text = str(achievement.ach_accepted_rewards * achievement.ach_reward_growth)
		
		if achievement.ach_reward_in_percentage:
			reward_amount_label.text +=  " %"
			
		next_reward_label.hide()

func setup_ducks() -> void:
	match achievement.ach_requirement.size():
		1:
			achieved_icon_2.hide()
			achieved_icon_3.hide()
			achieved_icon_4.hide()
		2:
			achieved_icon_3.hide()
			achieved_icon_4.hide()
		
		3:
			achieved_icon_4.hide()
		
		
	if achievement.ach_accepted_rewards > 0:
		achieved_icon.texture = DataStorage.ACHIEVED_DUCK
	if achievement.ach_accepted_rewards > 1:
		achieved_icon_2.texture = DataStorage.ACHIEVED_DUCK
	if achievement.ach_accepted_rewards > 2:
		achieved_icon_3.texture = DataStorage.ACHIEVED_DUCK
	if achievement.ach_accepted_rewards > 3:
		achieved_icon_4.texture = DataStorage.ACHIEVED_DUCK


func _on_get_reward_button_pressed():
	if achievement.ach_script.has_method("handle_reward"):
		achievement.ach_script.handle_reward()
		
	achievement.ach_accepted_rewards += 1
	AchievementManager.update_achievement_stats(achievement)
	complete_achievement.hide()
	update()
