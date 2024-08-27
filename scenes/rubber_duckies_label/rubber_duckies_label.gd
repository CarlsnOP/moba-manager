extends Label

func _ready():
	SignalManager.rubberduckies_updated.connect(rubberduckies_updated)

func rubberduckies_updated() -> void:
	update_text()
	
func update_text() -> void:
	text = "Rubberduckies: %s" %CurrencyManager.get_rubberduckies()
