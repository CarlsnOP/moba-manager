extends Control

const WANT_TO_QUIT_POP_UP = preload("res://scenes/utility/want_to_quit_pop_up/want_to_quit_pop_up.tscn")

@onready var notification_rect = %NotificationRect
@onready var notification_rect_2 = %NotificationRect2
@onready var rubber_duck_button = %RubberDuckButton

var rubber_ducky_page: Control

func _ready():
	rubber_ducky_page = get_tree().get_first_node_in_group("rubber_ducky_page")
	SignalManager.achievements_updated.connect(achievements_updated)
	SignalManager.on_loot_ducky.connect(on_loot_ducky)
	
	await get_tree().create_timer(0.2).timeout

	on_loot_ducky()

func achievements_updated() -> void:
	if AchievementManager.check_if_unclaimed_rewards():
		notification_rect.show()
	else:
		notification_rect.hide()

func on_loot_ducky() -> void:
	if InventoryManager.owned_hero_rubber_ducky > 0 or rubber_ducky_page.get_children().size() >= 2:
		#notification_rect_2.show()
		rubber_duck_button.show()
	else:
		#notification_rect_2.hide()
		rubber_duck_button.hide()

func _on_profile_button_pressed():
	SignalManager.new_interface.emit(9)

func _on_home_button_pressed():
	SignalManager.new_interface.emit(0)

func _on_heroes_button_pressed():
	SignalManager.new_interface.emit(1)

func _on_battle_setup_button_pressed():
	SignalManager.new_interface.emit(2)
	
func _on_battle_sim_button_pressed():
	SignalManager.new_interface.emit(3)

func _on_inventorybutton_pressed():
	SignalManager.new_interface.emit(4)

func _on_crafting_button_pressed():
	SignalManager.new_interface.emit(5)

func _on_shop_button_pressed():
	SignalManager.new_interface.emit(11)

func _on_rubber_duck_button_pressed():
	SignalManager.new_interface.emit(6)

func _on_settings_button_pressed():
	SignalManager.new_interface.emit(7)

func _on_achievementsbutton_pressed():
	SignalManager.new_interface.emit(8)

func _on_credits_button_pressed() -> void:
	SignalManager.new_interface.emit(10)

func _on_quit_button_pressed():
	var temp = get_tree().get_first_node_in_group("want_to_quit_pop_up")
	if temp:
		temp.queue_free()
	else:
		ObjectMakerManager.instantiate_scene(WANT_TO_QUIT_POP_UP)
