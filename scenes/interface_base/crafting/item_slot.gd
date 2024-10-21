extends PanelContainer

@onready var texture_rect = %TextureRect
@onready var stack_label: Label = %StackLabel

func display(item:ItemResource):
	texture_rect.texture = item.icon
	stack_label.text = "%s" % item.quantity
