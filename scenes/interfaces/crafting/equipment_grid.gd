class_name ItemGrid
extends GridContainer

@export var slot_scene:PackedScene
@export var equipped_items: bool


func display(items: Array[EquipmentResource]):
	for child in get_children():
		remove_child(child)
		child.queue_free()
	
	var seen_equipment: Dictionary = {}
	
	for equipment in items:
		if equipment != null and (equipment.quantity >= 1 or equipped_items):
			if equipped_items and equipment in seen_equipment:
				var original_child = seen_equipment[equipment]
				if original_child.has_method("add_item"):
					original_child.add_item()
			
			else:
				var slot = slot_scene.instantiate()
				add_child(slot)
				if equipped_items:
					slot.equipped_equipment()
				slot.display(equipment)
				seen_equipment[equipment] = slot


func display_result(items: Array[EquipmentResource]):
	for child in get_children():
		child.queue_free()
	
	for equipment in items:
		var slot = slot_scene.instantiate()
		add_child(slot)
		slot.display(equipment)
