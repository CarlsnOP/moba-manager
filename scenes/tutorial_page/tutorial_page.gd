class_name TutorialPage
extends PanelContainer

@onready var welcome_tut_step_1 = %WelcomeTutStep1
@onready var nickname_tut_step_2 = %NicknameTutStep2
@onready var nickname_line_edit = %NicknameLineEdit
@onready var open_rubber_ducks_step = %OpenRubberDucksStep
@onready var open_duck_page_step = %OpenDuckPageStep
@onready var click_duck_step = %ClickDuckStep
@onready var setup_team_step = %SetupTeamStep
@onready var click_battle_setup_step = %ClickBattleSetupStep
@onready var setup_both_heroes_step = %SetupBothHeroesStep
@onready var finish_first_step = %FinishFirstStep
@onready var enter_to_continue_label = %EnterToContinueLabel
@onready var first_step = %FirstStep
@onready var second_step = %SecondStep
@onready var third_step = %ThirdStep
@onready var fourth_step = %FourthStep
@onready var fifth_step = %FifthStep


#Set to 1 for start of tutorial
var tutorial_step := 1
var rubberducks_opened := 0

func _ready():
	show()
	connect_signals()
	match_step()

func connect_signals() -> void:
	SignalManager.new_interface.connect(check_interface)
	SignalManager.rubberduck_clicked.connect(handle_rubber_duck_clicked)
	SignalManager.hero_selected.connect(on_hero_selected)
	var temp_button = get_tree().get_first_node_in_group("battle_manager_top_hero_button") as Button
	var temp_button2 = get_tree().get_first_node_in_group("battle_manager_bot_hero_button") as Button
	temp_button.pressed.connect(check_step)
	temp_button2.pressed.connect(check_step)
	
func match_step() -> void:
	welcome_tut_step_1.hide()
	
	if tutorial_step >= 3:
		self_modulate = Color("ffffff00")
		mouse_filter = MOUSE_FILTER_IGNORE
	
	match tutorial_step:
		
		1:
			welcome_tut_step_1.show()
			
		2:
			welcome_tut_step_1.hide()
			nickname_tut_step_2.show()
			
		3:
			handle_rubberduck_step()
			
		4:
			open_rubber_ducks_step.show()
			open_duck_page_step.hide()
			click_duck_step.show()
			
		5:
			handle_setup_team_step()
		
		6:
			click_battle_setup_step.hide()
			setup_both_heroes_step.show()
		
		7:
			setup_team_step.hide()
			finish_first_step.show()
		
		8:
			finish_first_step.hide()
			first_step.show()
		
		9:
			first_step.hide()
			second_step.show()
		
		10:
			second_step.hide()
			third_step.show()
		
		11:
			third_step.hide()
			fourth_step.show()
		
		12:
			fourth_step.hide()
			fifth_step.show()
		
		13:
			queue_free()

func check_interface(interface: int) -> void:
	if interface == 6 and tutorial_step == 3:
		handle_next_step()
	
	elif interface and tutorial_step == 4:
		tutorial_step = 3
		match_step()
	
	if interface == 2 and tutorial_step == 5:
		handle_next_step()
	
	elif interface and tutorial_step == 6:
		tutorial_step = 5
		match_step()

func check_step() -> void:
	if tutorial_step == 10:
		handle_next_step()

func handle_next_step() -> void:
	tutorial_step += 1
	match_step()
	
func handle_rubberduck_step() -> void:
	nickname_tut_step_2.hide()
	open_rubber_ducks_step.show()
	open_duck_page_step.show()
	click_duck_step.hide()
	
	await get_tree().physics_frame
	if check_for_heroes():
		tutorial_step += 1
		handle_next_step()

func handle_setup_team_step() -> void:
	setup_both_heroes_step.hide()
	open_rubber_ducks_step.hide()
	setup_team_step.show()
	click_battle_setup_step.show()

func on_hero_selected() -> void:
	if TeamManager.bot != null and TeamManager.top != null:
		handle_next_step()

func handle_rubber_duck_clicked() -> void:
	rubberducks_opened += 1
	if rubberducks_opened >= 2 or check_for_heroes():
		handle_next_step()

func check_for_heroes() -> bool:
	var count := 0
	
	for hero in TeamManager._all_heroes:
		if hero.unlocked:
			count += 1
			
	if count >= 2:
		return true
		
	return false

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ENTER:
			if tutorial_step != 2:
				handle_next_step()

func _on_tutorial_button_pressed():
	handle_next_step()
	
func _on_nickname_line_edit_text_submitted(_new_text):
	name_entered()

func _on_nickname_button_pressed():
	name_entered()


func name_entered() -> void:
	if nickname_line_edit.text.length() > 2:
		var profile = get_tree().get_first_node_in_group("profile_page")
		profile.set_nickname(nickname_line_edit.text)
		handle_next_step()
	else:
		enter_to_continue_label.text = "Name has to be atleast 3 charecters!"
		enter_to_continue_label.modulate = DataStorage.COLOR_RED

func _on_finish_first_tutorial_button_pressed():
	SignalManager.restart_match.emit()
	handle_next_step()

func _on_finish_tut_button_pressed():
	AchievementManager.tutorial_completed = true
	AchievementManager.update_achievements()
	handle_next_step()
