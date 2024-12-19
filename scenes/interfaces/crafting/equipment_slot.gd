extends PanelContainer

@onready var texture_rect = %TextureRect
@onready var stack_label: Label = %StackLabel
@onready var particles = %Particles
@onready var border = %Border

var _equipment: EquipmentResource = null
var _original_quantity := 1

func display(equipment: EquipmentResource):
	texture_rect.texture = equipment.icon
	stack_label.text = "%s" % equipment.quantity
	_equipment = equipment
	
	
	match equipment.rarity:
		0:
			particles.modulate = Color(0,0,0,0)
			border.modulate = Color(0,0,0,0)
		1:
			particles.modulate = Color(0,1,0)
			border.modulate = Color(0,1,0)
		2:
			particles.modulate = Color(0,0,1)
			border.modulate = Color(0,0,1)
		3:
			particles.modulate = Color(1,0,1)
			border.modulate = Color(1,0,1)
		4:
			particles.modulate = Color(1,1,0)
			border.modulate = Color(1,1,0)

func equipped_equipment() -> void:
	stack_label.hide()

func add_equipment() -> void:
	_original_quantity += 1
	stack_label.show()
	stack_label.text = "%s" % _original_quantity

func update_quantity() -> void:
	stack_label.text = "%s" % _equipment.quantity

func get_item() -> EquipmentResource:
	return _equipment

func _on_mouse_entered() -> void:
	if _equipment == null:
		return
		
	Popups.show_popup(Rect2i( Vector2i(global_position), Vector2i(size)), _equipment)

func _on_mouse_exited() -> void:
	Popups.hide_popup()
