extends Control

enum INTERFACE_STATE { HOME, HEROES, BATTLESETUP, BATTLESIM, INVENTORY, CRAFTING, HIGHSCORE, SETTINGS }

@onready var heroes = %Heroes
@onready var battle_setup = %BattleSetup
@onready var home = %Home
@onready var inventory = %Inventory
@onready var crafting = %Crafting

var _state: INTERFACE_STATE = INTERFACE_STATE.HOME

func _ready():
	SignalManager.new_interface.connect(new_interface)
	heroes.add_heroes()
	battle_setup.add_heroes()
	crafting.open()

func hide_interface() -> void:
	home.hide()
	heroes.hide()
	battle_setup.hide()
	inventory.hide()
	crafting.hide()
	

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
			heroes.show()
		INTERFACE_STATE.BATTLESETUP:
			battle_setup.show()
		INTERFACE_STATE.INVENTORY:
			inventory.show()
			inventory.open()
		INTERFACE_STATE.CRAFTING:
			crafting.show()
			crafting.open()

			
