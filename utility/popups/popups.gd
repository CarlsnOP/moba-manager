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
	reset_box()
	
#Cannot use match, hence ugly elif list
	if res is LootResource:
		name_label.text = res.name
		description_label.text = res.description
		effect_label.hide()
		name_label.modulate = FunctionWizard.apply_rarity_changes(res)
		
	elif res is SkillResource:
		name_label.text = res.name
		description_label.text = res.description
		name_label.modulate = Color(1,1,1)
		effect_label.text = res.effect
		effect_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		description_label.custom_minimum_size.x = 500
		
	elif res is EquipmentResource:
		name_label.text = res.name
		description_label.text = res.description
		effect_label.text = res.effect
		name_label.modulate = FunctionWizard.apply_rarity_changes(res)
		
	elif res is HeroResource:
		name_label.text = res.hero_name
		description_label.text = FunctionWizard.setup_stats_string(res)
		description_label.custom_minimum_size.x = 300
		effect_label.text = res.type
		name_label.modulate = DataStorage.COLOR_WHITE

				
func reset_box() -> void:
	effect_label.show()
	description_label.custom_minimum_size.x = 0
	effect_label.autowrap_mode = TextServer.AUTOWRAP_OFF
