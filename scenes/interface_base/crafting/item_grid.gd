class_name ItemGrid
extends GridContainer

@export var slot_scene:PackedScene
@export var equipped_items: bool


func display(items: Array[ItemResource]):
	for child in get_children():
		child.queue_free()
	
	for item in items:
		if item != null:
			if item.quantity >= 1:
				var slot = slot_scene.instantiate()
				add_child(slot)
				if equipped_items:
					slot.equipped_item()
				slot.display(item)
	
	if equipped_items:
		check_for_duplicates()

func display_result(items: Array[ItemResource]):
	for child in get_children():
		child.queue_free()
	
	for item in items:
		var slot = slot_scene.instantiate()
		add_child(slot)
		slot.display(item)

func check_for_duplicates() -> void:
	var seen_items: Dictionary = {}
	
	for child in get_children():
		if child.has_method("get_item"):
			var item_resource = child.get_item()
			
			if seen_items.has(item_resource):
				var original_child = seen_items[item_resource]
				if original_child.has_method("add_item"):
					original_child.add_item()
				child.queue_free()
			else:
				seen_items[item_resource] = child
	
		
		
		
