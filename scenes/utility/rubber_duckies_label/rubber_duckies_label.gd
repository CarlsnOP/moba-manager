extends Label

func on_before_load_game():
	await get_tree().physics_frame
	update_text()

func _ready():
	SignalManager.rubberduckies_updated.connect(rubberduckies_updated)

func rubberduckies_updated() -> void:
	update_text()
	
func update_text() -> void:
	text = "Rubberduckies: %s" %InventoryManager.get_rubberduckies()
