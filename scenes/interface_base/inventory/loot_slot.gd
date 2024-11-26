extends PanelContainer

@onready var texture_rect = %TextureRect
@onready var stack_label: Label = %StackLabel
@onready var particles = %Particles
@onready var border = %Border

var _loot: LootResource = null
var _original_quantity := 1


func display(loot: LootResource):
	texture_rect.texture = loot.icon
	stack_label.text = "%s" % loot.quantity
	_loot = loot
	
	match loot.rarity:
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

func update_quantity() -> void:
	stack_label.text = "%s" % _loot.quantity

func update_cost(cost: int) -> void:
	stack_label.text += "/%s" % cost

func loot_reward() -> void:
	stack_label.text = "%s" % _original_quantity

func add_loot() -> void:
	_original_quantity += 1
	stack_label.show()
	stack_label.text = "%s" % _original_quantity

func get_loot() -> LootResource:
	return _loot

func _on_mouse_entered() -> void:
	if _loot == null:
		return
		
	Popups.show_popup(Rect2i( Vector2i(global_position), Vector2i(size)), _loot)

func _on_mouse_exited() -> void:
	Popups.hide_popup()
