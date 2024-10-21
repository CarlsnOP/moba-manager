extends PanelContainer

@onready var texture_rect = %TextureRect

func display(item:ItemResource):
	texture_rect.texture = item.icon
