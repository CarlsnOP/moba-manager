class_name FunctionWizard
extends Node


static func give_offline_reward(old_time: int) -> void:
	var new_time := int(Time.get_unix_time_from_system())
	var calc_time_difference := new_time - old_time
	
	print(calc_time_difference)
