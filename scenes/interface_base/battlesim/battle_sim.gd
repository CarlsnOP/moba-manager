extends Control

@onready var battle_manager = %BattleManager

var buddy = preload("res://scenes/interface_base/battlesim/buddy/buddy.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.new_interface.connect(new_interface)
	
func new_interface(interface: int) -> void:
	if interface == 3:
		battle_manager.show()
	else:
		battle_manager.hide()

func _on_buff_minion_button_pressed():
	CheatManager.health += 100
	CheatManager.damage += 100

func _on_reset_minion_button_pressed():
	CheatManager.health = 500
	CheatManager.damage = 150
