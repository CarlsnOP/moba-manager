extends Control

@onready var battle_manager = %BattleManager
	
func new_interface(interface: int) -> void:
	if interface == 3:
		battle_manager.show()
	else:
		battle_manager.hide()
