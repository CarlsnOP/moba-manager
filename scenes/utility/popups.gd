extends Control

@onready var resource_popup = %ResourcePopup
@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel
@onready var effect_label = %EffectLabel

func show_popup(slot: Rect2i, res: Resource):
	if res != null:
		set_value(res)
		resource_popup.size = Vector2i.ZERO
	
	var mouse_pos = get_viewport().get_mouse_position()
	var correction: Vector2i
	var padding := 4
	
	if mouse_pos.x <= get_viewport_rect().size.x/2:
		correction = Vector2i(slot.size.x + padding, 0)
	else:
		correction = -Vector2i(resource_popup.size.x + padding, 0)
	
	resource_popup.popup(Rect2i(slot.position + correction, resource_popup.size))

func hide_popup():
	resource_popup.hide()

func set_value(res: Resource):
	name_label.text = res.name
	description_label.text = res.description
	
	if res is SkillResource:
		effect_label.text = res.effect
		
	elif res is LootResource:
		effect_label.hide()
	elif res is ItemResource:
		effect_label.text = res.effect
