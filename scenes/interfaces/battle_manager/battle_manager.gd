extends Control

@onready var top_hero_button = %TopHeroButton
@onready var bot_hero_button = %BotHeroButton
@onready var fast_forward_button: Button = $MarginContainer/VB/FastForwardButton

var selected_hero: Hero
var selected_lane_manager_component: LaneManagerComponent
var selected_state_machine_component: StateMachineComponent
var top_hero_res: HeroResource
var bot_hero_res: HeroResource
var top_hero_node: CharacterBody2D
var bot_hero_node: CharacterBody2D
var top_lane := true
var bot_lane := false

func _ready():
	call_deferred("update")

func update() -> void:
	top_hero_res = TeamManager.top
	bot_hero_res = TeamManager.bot
	
	for hero in get_tree().get_nodes_in_group("hero"):
		if hero.has_method("get_hero_resource"):
			var temp_res_storage = hero.get_hero_resource()
			
			match temp_res_storage:
				top_hero_res:
					top_hero_node = hero
					top_hero_button.icon = top_hero_res.hero_portrait
				
				bot_hero_res:
					bot_hero_node = hero
					bot_hero_button.icon = bot_hero_res.hero_portrait

func switch_active_button(top: bool) -> void:
	if top:
		top_hero_button.flat = false
		bot_hero_button.flat = true
	else:
		top_hero_button.flat = true
		bot_hero_button.flat = false

func _on_top_hero_button_pressed():
	switch_active_button(top_lane)
	selected_hero = top_hero_node
	selected_lane_manager_component = selected_hero.get_lane_manager_component()
	selected_state_machine_component = selected_hero.get_state_machine_component()

func _on_bot_hero_button_pressed():
	switch_active_button(bot_lane)
	selected_hero = bot_hero_node
	selected_lane_manager_component = selected_hero.get_lane_manager_component()
	selected_state_machine_component = selected_hero.get_state_machine_component()
	
func _on_top_button_pressed():
	if selected_state_machine_component != null:
		selected_lane_manager_component.on_lane_change(top_lane)

func _on_bot_button_pressed():
	if selected_state_machine_component != null:
		selected_lane_manager_component.on_lane_change(bot_lane)

func _on_retreat_button_pressed() -> void:
	if selected_state_machine_component != null:
		selected_state_machine_component.on_child_transition("RetreatState")

func _on_fast_forward_button_pressed() -> void:
	var homepage = get_tree().get_first_node_in_group("homepage") as Homepage
	if homepage.has_method("set_fast_forward"):
		homepage.set_fast_forward()


func _on_end_battle_button_pressed():
	SignalManager.on_battle_end.emit(true)
