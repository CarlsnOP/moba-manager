extends Control


@onready var grid_container = %GridContainer
@onready var hero_menu = %HeroMenu
@onready var top_button = %TopButton
@onready var bot_button = %BotButton

@export var slot_scene: PackedScene


var hero_in_selected_lane

func on_before_load_game():
	await get_tree().physics_frame
	if TeamManager.top == null:
		top_button.icon = DataStorage.ADD_EQUIPMENT
	else:
		top_button.icon = TeamManager.top.hero_portrait
	if TeamManager.bot == null:
		bot_button.icon = DataStorage.ADD_EQUIPMENT
	else:
		bot_button.icon = TeamManager.bot.hero_portrait

func add_heroes():
	for child in grid_container.get_children():
		child.queue_free()
	
	for hero in TeamManager._all_heroes:
		if hero.unlocked and hero != hero_in_selected_lane:
			var slot = slot_scene.instantiate()
			grid_container.add_child(slot)
			slot.add_to_group("hero_buttons")
			slot.display(hero)
			slot.hero_selected.connect(on_portrait_selected)

#This is a monster. Sorry xD
func on_portrait_selected(hero: HeroResource) -> void:
	hero_menu.hide()
	
	
	match TeamManager._lane:
		
		TeamManager.LANE_SELECTED.TOP:
			if hero == TeamManager.bot:
				TeamManager._lane = TeamManager.LANE_SELECTED.BOT
				
				if TeamManager.top != null:
					TeamManager.setup_team(TeamManager.top)
					bot_button.icon = TeamManager.top.hero_portrait
					
				else:
					TeamManager.bot = null
					bot_button.icon = DataStorage.ADD_EQUIPMENT
					
				TeamManager._lane = TeamManager.LANE_SELECTED.TOP
				
			top_button.icon = hero.hero_portrait
			TeamManager.setup_team(hero)
			
		TeamManager.LANE_SELECTED.BOT:
			if hero == TeamManager.top:
				TeamManager._lane = TeamManager.LANE_SELECTED.TOP
				
				if TeamManager.bot != null:
					TeamManager.setup_team(TeamManager.bot)
					top_button.icon = TeamManager.bot.hero_portrait
					
				else:
					TeamManager.top = null
					top_button.icon = DataStorage.ADD_EQUIPMENT
					
				TeamManager._lane = TeamManager.LANE_SELECTED.BOT
				
			bot_button.icon = hero.hero_portrait
			TeamManager.setup_team(hero)
			
	SignalManager.hero_selected.emit()


func button_pressed_logic() -> void:
	if hero_menu.visible:
		hero_menu.hide()
		return
		
	add_heroes()
	hero_menu.show()

func _on_top_button_pressed():
	hero_in_selected_lane = TeamManager.top
	button_pressed_logic()
	TeamManager._lane = TeamManager.LANE_SELECTED.TOP

func _on_bot_button_pressed():
	hero_in_selected_lane = TeamManager.bot
	button_pressed_logic()
	TeamManager._lane = TeamManager.LANE_SELECTED.BOT

func _on_exit_button_pressed() -> void:
	hero_menu.hide()

func _on_quit_button_pressed():
	SignalManager.new_interface.emit(InterfaceManager.INTERFACE_STATE.BATTLESIM)
