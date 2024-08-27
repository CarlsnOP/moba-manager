class_name SaverLoader
extends Node

@onready var nav_menu = %NavMenu

func save_game():
	var file = FileAccess.open("res://savegame.data", FileAccess.WRITE)
	file.store_var(CurrencyManager.get_rubberduckies())
	file.close()
	

func load_game():
	var file = FileAccess.open("res://savegame.data", FileAccess.READ)
	CurrencyManager._rubberduckies = file.get_var()
	file.close()
