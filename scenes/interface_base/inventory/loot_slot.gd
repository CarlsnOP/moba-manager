extends PanelContainer

@onready var texture_rect = %TextureRect

func display(loot:LootResource):
	texture_rect.texture = loot.icon
