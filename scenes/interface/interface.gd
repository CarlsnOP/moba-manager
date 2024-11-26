extends Control

enum INTERFACE_STATE { HOME, HEROES, BATTLESETUP, BATTLESIM, INVENTORY, CRAFTING, RANK, SETTINGS }

@onready var heroes = %Heroes
@onready var battle_setup = %BattleSetup
@onready var home = %Home
@onready var inventory = %Inventory
@onready var crafting = %Crafting
@onready var rank = %Rank
@onready var settings: Control = %Settings

var _state: INTERFACE_STATE = INTERFACE_STATE.HOME

func _ready():
	SignalManager.new_interface.connect(new_interface)
	heroes.add_heroes()
	battle_setup.add_heroes()
	crafting.open()

func hide_interface() -> void:
	var all_interfaces = get_children()
	
	for interface in all_interfaces:
		interface.hide()

func new_interface(state: int) -> void:
	set_state(state)

func set_state(new_state: INTERFACE_STATE) -> void:
	if new_state == _state:
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
			
		INTERFACE_STATE.RANK:
			rank.show()
			
		INTERFACE_STATE.SETTINGS:
			settings.show()
			
