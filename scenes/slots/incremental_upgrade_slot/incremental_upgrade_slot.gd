extends PanelContainer

@onready var name_label = %NameLabel
@onready var desc_label = %DescLabel
@onready var cost_label = %CostLabel
@onready var buy_button = %BuyButton

var _upgrade: ShopUpgradeResource
var _total_cost: int

func _ready():
	SignalManager.rubberduckies_updated.connect(update)
	
func display(upgrade: ShopUpgradeResource):
	_upgrade = upgrade
	
	name_label.text = upgrade.name
	desc_label.text = upgrade.description
	update()

func update() -> void:
	_total_cost = _upgrade.base_cost + (_upgrade.base_cost * _upgrade.level)
	
	if InventoryManager._rubberduckies >= _total_cost:
		buy_button.disabled = false
	else:
		buy_button.disabled = true
		
	cost_label.text = "Cost: " + str(_total_cost)

func _on_buy_button_pressed():
	InventoryManager.spend_rubberduckies(_total_cost)
	_upgrade.level += 1
	
	SignalManager.update_stats.emit()
	
	update()
