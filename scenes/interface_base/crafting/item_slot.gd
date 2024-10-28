extends PanelContainer

@onready var texture_rect = %TextureRect
@onready var stack_label: Label = %StackLabel
@onready var particles = %Particles

var _item: ItemResource = null

func display(item:ItemResource):
	texture_rect.texture = item.icon
	stack_label.text = "%s" % item.quantity
	_item = item
	
	match item.rarity:
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
	stack_label.text = "%s" % _item.quantity
