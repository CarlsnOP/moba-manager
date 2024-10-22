extends PanelContainer

@onready var texture_rect = %TextureRect
@onready var stack_label: Label = %StackLabel

func display(loot:LootResource):
	texture_rect.texture = loot.icon
	stack_label.text = "%s" % loot.quantity

func update_cost(cost: int) -> void:
	stack_label.text += "/%s" % cost
