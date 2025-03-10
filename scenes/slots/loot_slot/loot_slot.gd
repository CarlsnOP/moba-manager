extends PanelContainer

@onready var texture_rect = %TextureRect
@onready var stack_label: Label = %StackLabel
@onready var particles = %Particles
@onready var border = %Border

var _loot: LootResource = null
var _original_quantity := 1
var _rarity: int
var _name: String


func display(loot: LootResource):
	texture_rect.texture = loot.icon
	stack_label.text = "%s" % loot.quantity
	_loot = loot
	_rarity = loot.rarity
	_name  = loot.name
	
	match loot.rarity:
		LootResource.RARITY.COMMON:
			particles.modulate = DataStorage.COLOR_INVISABLE
			border.modulate = DataStorage.COLOR_INVISABLE
			
		LootResource.RARITY.UNCOMMON:
			particles.modulate = DataStorage.COLOR_UNCOMMON
			border.modulate = DataStorage.COLOR_UNCOMMON
			
		LootResource.RARITY.RARE:
			particles.modulate = DataStorage.COLOR_RARE
			border.modulate = DataStorage.COLOR_RARE
			
		LootResource.RARITY.EPIC:
			particles.modulate = DataStorage.COLOR_EPIC
			border.modulate = DataStorage.COLOR_EPIC
			
		LootResource.RARITY.LEGENDARY:
			particles.modulate = DataStorage.COLOR_LEGENDARY
			border.modulate = DataStorage.COLOR_LEGENDARY

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
