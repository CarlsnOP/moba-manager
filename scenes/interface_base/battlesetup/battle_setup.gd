extends Control


@onready var grid_container = %GridContainer
@onready var hero_menu = %HeroMenu
@onready var top_button = %TopButton
@onready var bot_button = %BotButton
@onready var jungle_button = %JungleButton

@export var slot_scene: PackedScene

func on_before_load_game():
	await get_tree().physics_frame
	top_button.icon = TeamManager.top.hero_portrait
	bot_button.icon = TeamManager.bot.hero_portrait
	jungle_button.icon = TeamManager.jungle.hero_portrait

func _ready():
	SignalManager.on_portrait_selected.connect(on_portrait_selected)

func add_heroes():
	get_tree().call_group("hero_buttons", "picked")
	
	for hero in TeamManager._all_heroes:
		if !hero.in_team:
			var slot = slot_scene.instantiate()
			grid_container.add_child(slot)
			slot.add_to_group("hero_buttons")
			slot.display(hero)

func on_portrait_selected(hero: HeroResource) -> void:
	hero_menu.hide()
	
	match TeamManager._lane:
		TeamManager.LANE_SELECTED.TOP:
			top_button.icon = hero.hero_portrait
			TeamManager.setup_team(hero)
		TeamManager.LANE_SELECTED.BOT:
			bot_button.icon = hero.hero_portrait
			TeamManager.setup_team(hero)
		TeamManager.LANE_SELECTED.JUNGLE:
			jungle_button.icon = hero.hero_portrait
			TeamManager.setup_team(hero)
		

func open_hero_menu() -> void:
	hero_menu.show()

func _on_top_button_pressed():
	TeamManager._lane = TeamManager.LANE_SELECTED.TOP
	add_heroes()
	open_hero_menu()

func _on_bot_button_pressed():
	TeamManager._lane = TeamManager.LANE_SELECTED.BOT
	add_heroes()
	open_hero_menu()

func _on_jungle_button_pressed():
	TeamManager._lane = TeamManager.LANE_SELECTED.JUNGLE
	add_heroes()
	open_hero_menu()
