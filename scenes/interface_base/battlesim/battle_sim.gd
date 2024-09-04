extends Control

@onready var battle_manager = %BattleManager

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.new_interface.connect(new_interface)
	
func new_interface(interface: int) -> void:
	if interface == 3:
		battle_manager.show()
	else:
		battle_manager.hide()
