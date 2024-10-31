extends Control

@onready var skill_popup: PopupPanel = %SkillPopup
@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel
@onready var item_popup: PopupPanel = %ItemPopup
@onready var item_name_label: Label = %ItemNameLabel
@onready var item_description_label: Label = %ItemDescriptionLabel


func show_skill_popup(slot: Rect2i, skill: SkillResource):
	if skill != null:
		set_value(skill)
		skill_popup.size = Vector2i.ZERO
	
	var mouse_pos = get_viewport().get_mouse_position()
	var correction: Vector2i
	var padding := 4
	
	if mouse_pos.x <= get_viewport_rect().size.x/2:
		correction = Vector2i(slot.size.x + padding, 0)
	else:
		correction = -Vector2i(skill_popup.size.x + padding, 0)
	
	skill_popup.popup(Rect2i(slot.position + correction, skill_popup.size))

func hide_skill_popup():
	skill_popup.hide()

func set_value(skill: SkillResource):
	name_label.text = skill.name
	description_label.text = skill.description

func show_item_popup(slot: Rect2i, item: ItemResource):
	if item != null:
		set_item_value(item)
		item_popup.size = Vector2i.ZERO
	
	var mouse_pos = get_viewport().get_mouse_position()
	var correction: Vector2i
	var padding := 4
	
	if mouse_pos.x <= get_viewport_rect().size.x/2:
		correction = Vector2i(slot.size.x + padding, 0)
	else:
		correction = -Vector2i(item_popup.size.x + padding, 0)
	
	item_popup.popup(Rect2i(slot.position + correction, item_popup.size))

func hide_item_popup():
	item_popup.hide()

func set_item_value(item: ItemResource):
	item_name_label.text = item.name
	item_description_label.text = item.description
