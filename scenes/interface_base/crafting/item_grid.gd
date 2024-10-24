class_name ItemGrid
extends GridContainer

@export var slot_scene:PackedScene


func display(items: Array[ItemResource]):
	for child in get_children():
		child.queue_free()
	
	for item in items:
		if item.quantity >= 1:
			var slot = slot_scene.instantiate()
			add_child(slot)
			slot.display(item)

func display_result(items: Array[ItemResource]):
	for child in get_children():
		child.queue_free()
	
	for item in items:
		var slot = slot_scene.instantiate()
		add_child(slot)
		slot.display(item)
