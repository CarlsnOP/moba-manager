extends Node


var _rubberduckies := 0


func on_battle_end(win: bool) -> void:
	if win:
		create_rubberduckies(100)
	else:
		create_rubberduckies(10)

func get_rubberduckies() -> int:
	return _rubberduckies

func create_rubberduckies(quantity: int) -> void:
	if quantity <= 0:
		return
	
	_rubberduckies += quantity
	
	SignalManager.rubberduckies_created.emit(quantity)
	SignalManager.rubberduckies_updated.emit()

func can_spend(quantity: int) -> bool:
	if quantity < 0:
		return false
	
	if quantity > _rubberduckies:
		return false
	
	return true

func spend_rubberduckies(quantity: int) -> Error:
	if quantity < 0:
		return Error.FAILED
	
	if quantity > _rubberduckies:
		return Error.FAILED
	
	_rubberduckies -= quantity
	
	SignalManager.rubberduckies_spent.emit(quantity)
	SignalManager.rubberduckies_updated.emit()
	
	return Error.OK
