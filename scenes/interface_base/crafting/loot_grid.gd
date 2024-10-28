class_name LootGrid
extends GridContainer

@export var slot_scene:PackedScene


func display(loot: Array[LootResource]):
	for child in get_children():
		child.queue_free()
	
	for item in loot:
		if item.quantity >= 1:
			var slot = slot_scene.instantiate()
			add_child(slot)
			slot.display(item)

func display_recipe(loot: Array[LootResource], cost: int):
	for child in get_children():
		child.queue_free()
	
	for item in loot:
		var slot = slot_scene.instantiate()
		add_child(slot)
		slot.display(item)
		slot.update_cost(cost)

func update_quanities() -> void:
	for loot in get_children():
		loot.update_quantity()
