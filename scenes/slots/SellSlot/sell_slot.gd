extends PanelContainer

const WANT_TO_SELL = preload("res://scenes/interfaces/shop/want_to_sell.tscn")

@export var loot_slot_scene:PackedScene

@onready var hb = %HB
@onready var loot_name_label = %LootNameLabel
@onready var price_label = %PriceLabel
@onready var amount_slider = %AmountSlider
@onready var amount_label = %AmountLabel
@onready var sell_button = %SellButton

var loot_price: int
var total_loot_price: int
var loot: LootResource

func display(l: LootResource):
	loot = l
	
	var loot_to_sell = loot_slot_scene.instantiate()
	hb.add_child(loot_to_sell)
	hb.move_child(loot_to_sell, 0)
	loot_to_sell.display(loot)
	
	loot_price = FunctionWizard.price_by_rarity(loot)
	
	loot_name_label.text = loot.name
	amount_slider.max_value = loot.quantity

func _on_amount_slider_value_changed(value):
	amount_label.text = str(value)
	total_loot_price = loot_price * value
	price_label.text = str(total_loot_price)
	
	if value > 0: 
		sell_button.disabled = false
	else:
		sell_button.disabled = true

func _on_sell_button_pressed():
	ObjectMakerManager.instantiate_sell_scene(WANT_TO_SELL, amount_slider.value, total_loot_price, loot)
