class_name LootGrid
extends GridContainer

@export var slot_scene:PackedScene
@export var loot_reward := false

var total_loot_slots: int

func display(loot: Array[LootResource]):
	for child in get_children():
		child.queue_free()
	
	for item in loot:
		if item.quantity >= 1:
			var slot = slot_scene.instantiate()
			add_child(slot)
			slot.display(item)
			
			if loot_reward:
				slot.loot_reward()
			
	if loot_reward:
		check_for_duplicates()

func display_recipe(loot: Array[LootResource], cost: Array[int]):
	for child in get_children():
		child.queue_free()
	
	for i in range(loot.size()):
		var slot = slot_scene.instantiate()
		add_child(slot)
		slot.display(loot[i])
		slot.update_cost(cost[i])

func check_for_duplicates() -> void:
	var seen_loot: Dictionary = {}
	
	for child in get_children():
		if child.has_method("get_loot"):
			var loot_resource = child.get_loot()
			
			if seen_loot.has(loot_resource):
				var original_child = seen_loot[loot_resource]
				if original_child.has_method("add_loot"):
					original_child.add_loot()
				child.queue_free()
			else:
				seen_loot[loot_resource] = child
	total_loot_slots = seen_loot.size()
