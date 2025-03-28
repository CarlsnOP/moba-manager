class_name InterfaceManager
extends Control

enum INTERFACE_STATE { HOME, HEROES, BATTLESETUP, BATTLESIM, INVENTORY, CRAFTING, RUBBERDUCKY, SETTINGS, ACHIEVEMENTS, PROFILE, CREDITS, SHOP }

@onready var heroes = %Heroes
@onready var battle_setup = %BattleSetup
@onready var home = %Home
@onready var inventory = %Inventory
@onready var crafting = %Crafting
@onready var rubber_ducky_page = %RubberDuckyPage
@onready var rank = %Rank
@onready var settings: Control = %Settings
@onready var achievements = %Achievements
@onready var profile = %Profile
@onready var credits: Control = %Credits
@onready var shop = %Shop


var _state: INTERFACE_STATE

func _ready():
	SignalManager.new_interface.connect(new_interface)
	heroes.add_heroes()
	battle_setup.add_heroes()
	crafting.open()

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			hide_interface()
			_state = INTERFACE_STATE.BATTLESIM

func hide_interface() -> void:
	var all_interfaces = get_children()
	
	for interface in all_interfaces:
		interface.hide()

func new_interface(state: int) -> void:
	set_state(state)

func set_state(new_state: INTERFACE_STATE) -> void:
	if new_state == _state:
		hide_interface()
		_state = INTERFACE_STATE.BATTLESIM
		return
	
	_state = new_state
	hide_interface()
	
	match _state:
		INTERFACE_STATE.HOME:
			home.show()
			
		INTERFACE_STATE.HEROES:
			var hero_buttons = get_tree().get_nodes_in_group("hero_buttons")
			
			for button in hero_buttons:
				if button.has_method("update"):
					button.update()
					
			heroes.show()
			
		INTERFACE_STATE.BATTLESETUP:
			battle_setup.show()
			
		INTERFACE_STATE.INVENTORY:
			inventory.show()
			inventory.open()
			
		INTERFACE_STATE.CRAFTING:
			crafting.show()
			crafting.open()
			
		INTERFACE_STATE.RUBBERDUCKY:
			rubber_ducky_page.update()
			rubber_ducky_page.show()
			
		INTERFACE_STATE.SETTINGS:
			settings.show()
			
		INTERFACE_STATE.ACHIEVEMENTS:
			achievements.show()
			achievements.open()
			
		INTERFACE_STATE.PROFILE:
			var hero_buttons = get_tree().get_nodes_in_group("hero_buttons")
			
			for button in hero_buttons:
				if button.has_method("update"):
					button.update()
					
			profile.show()
			profile.stats_updated()
			
		INTERFACE_STATE.CREDITS:
			credits.show()
		
		INTERFACE_STATE.SHOP:
			shop.show()
		
func reassign_home(saved_home: Control) -> void:
	move_child(saved_home, 0)
	home = saved_home
	
func reassign_settings(saved_settings: Control) -> void:
	settings = saved_settings
