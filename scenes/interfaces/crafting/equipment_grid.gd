class_name ItemGrid
extends GridContainer

@export var slot_scene:PackedScene
@export var equipped_items: bool


func display(items: Array[EquipmentResource]):
	for child in get_children():
		child.queue_free()
	
	for equipment in items:
		if equipment != null:
			if equipment.quantity >= 1:
				var slot = slot_scene.instantiate()
				add_child(slot)
				if equipped_items:
					slot.equipped_item()
				slot.display(equipment)
	
	if equipped_items:
		check_for_duplicates()

func display_result(items: Array[EquipmentResource]):
	for child in get_children():
		child.queue_free()
	
	for equipment in items:
		var slot = slot_scene.instantiate()
		add_child(slot)
		slot.display(equipment)

func check_for_duplicates() -> void:
	var seen_equipment: Dictionary = {}
	
	for child in get_children():
		if child.has_method("get_item"):
			var equipment_resource = child.get_item()
			
			if seen_equipment.has(equipment_resource):
				var original_child = seen_equipment[equipment_resource]
				if original_child.has_method("add_item"):
					original_child.add_item()
				child.queue_free()
			else:
				seen_equipment[equipment_resource] = child
	
		
		
		
