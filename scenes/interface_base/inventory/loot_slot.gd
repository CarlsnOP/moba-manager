extends PanelContainer

@onready var texture_rect = %TextureRect
@onready var stack_label: Label = %StackLabel
@onready var particles = %Particles

var _loot: LootResource = null

func display(loot: LootResource):
	texture_rect.texture = loot.icon
	stack_label.text = "%s" % loot.quantity
	_loot = loot
	
	match loot.rarity:
		0:
			particles.modulate = Color(0,0,0,0)
		1:
			particles.modulate = Color(0,1,0)
		2:
			particles.modulate = Color(0,0,1)
		3:
			particles.modulate = Color(1,0,1)
		4:
			particles.modulate = Color(1,1,0)

func update_quantity() -> void:
	stack_label.text = "%s" % _loot.quantity

func update_cost(cost: int) -> void:
	stack_label.text += "/%s" % cost
