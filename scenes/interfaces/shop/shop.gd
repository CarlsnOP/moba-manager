class_name Shop
extends Control

@onready var grid_container = %GridContainer
@onready var goods_list_vb = %GoodsListVB

var _all_shop_upgrades: Array[ShopUpgradeResource]

func _ready():
	for file in DirAccess.get_files_at("res://resources/shop_upgrades/resources/"):
		var resource_file = "res://resources/shop_upgrades/resources/" + file
		var upgrade: ShopUpgradeResource = load(resource_file) as ShopUpgradeResource
		_all_shop_upgrades.append(upgrade)
	
	await get_tree().physics_frame
	goods_list_vb.display(_all_shop_upgrades)

func refresh() -> void:
	grid_container.display(InventoryManager._all_loot)

func _on_quit_button_pressed():
	SignalManager.new_interface.emit(InterfaceManager.INTERFACE_STATE.BATTLESIM)

#FOR SAVING AND LOADING
func get_upgrade_levels() -> Array:
	var temp_array := []
	for upgrade in _all_shop_upgrades:
		temp_array.append(upgrade.level)
	return temp_array
	
func set_upgrade_levels(upgrade_levels: Array) -> void:
	if upgrade_levels.size() != _all_shop_upgrades.size():
		return
	
	for upgrade in range(_all_shop_upgrades.size()):
		_all_shop_upgrades[upgrade].level = upgrade_levels[upgrade]
