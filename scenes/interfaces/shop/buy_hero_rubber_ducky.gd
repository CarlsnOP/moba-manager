extends PanelContainer

const HERO_RUBBER_DUCKY_COST := 10000

@onready var buy_button = %BuyButton

func _ready():
	SignalManager.rubberduckies_updated.connect(update)
	update()

func update() -> void:
	if InventoryManager._rubberduckies >= HERO_RUBBER_DUCKY_COST:
		buy_button.disabled = false
	else:
		buy_button.disabled = true
		

func _on_buy_button_pressed():
	InventoryManager.spend_rubberduckies(HERO_RUBBER_DUCKY_COST)
	InventoryManager.get_loot_ducky(1)
	
	update()
