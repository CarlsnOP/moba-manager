extends TabContainer

@onready var grid_container = %GridContainer
@onready var goods_list_vb = %GoodsListVB

var shop_ref: Shop

func _ready():
	shop_ref = get_tree().get_first_node_in_group("shop")

func _on_tab_clicked(tab):
	if tab == 1:
		grid_container.display(InventoryManager._all_loot)
