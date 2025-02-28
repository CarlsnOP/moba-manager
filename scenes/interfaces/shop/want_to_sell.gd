extends PanelContainer

@onready var amount_label = %AmountLabel
@onready var loot_texture_rect = %LootTextureRect
@onready var price_label = %PriceLabel

var price: int
var amount: int
var loot: LootResource

func display(a: int, p: int, l: LootResource) -> void:
	price = p
	amount = a
	loot = l
	
	amount_label.text = str(a) + "X"
	price_label.text = str(p) + " Rubber duckies"
	loot_texture_rect.texture = l.icon

func _on_no_button_pressed():
	queue_free()


func _on_yes_button_pressed():
	InventoryManager._rubberduckies += price
	loot.quantity -= amount
	
	var shop = get_tree().get_first_node_in_group("shop")
	shop.refresh()
	SignalManager.rubberduckies_updated.emit()
	queue_free()
