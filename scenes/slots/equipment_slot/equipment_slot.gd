extends PanelContainer

@onready var texture_rect = %TextureRect
@onready var stack_label: Label = %StackLabel
@onready var particles = %Particles
@onready var border = %Border

var _equipment: EquipmentResource = null
var _original_quantity := 1
var _rarity: int
var _name: String

func display(equipment: EquipmentResource):
	texture_rect.texture = equipment.icon
	stack_label.text = "%s" % equipment.quantity
	_equipment = equipment
	_rarity = equipment.rarity
	_name  = equipment.name
	
	
	match equipment.rarity:
		EquipmentResource.RARITY.COMMON:
			particles.modulate = DataStorage.COLOR_INVISABLE
			border.modulate = DataStorage.COLOR_INVISABLE
			
		EquipmentResource.RARITY.UNCOMMON:
			particles.modulate = DataStorage.COLOR_UNCOMMON
			border.modulate = DataStorage.COLOR_UNCOMMON
			
		EquipmentResource.RARITY.RARE:
			particles.modulate = DataStorage.COLOR_RARE
			border.modulate = DataStorage.COLOR_RARE
			
		EquipmentResource.RARITY.EPIC:
			particles.modulate = DataStorage.COLOR_EPIC
			border.modulate = DataStorage.COLOR_EPIC
			
		EquipmentResource.RARITY.LEGENDARY:
			particles.modulate = DataStorage.COLOR_LEGENDARY
			border.modulate = DataStorage.COLOR_LEGENDARY

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
