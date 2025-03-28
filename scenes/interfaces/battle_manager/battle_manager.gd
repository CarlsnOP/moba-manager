extends Control

@export var log_scene: PackedScene

@onready var top_hero_button = %TopHeroButton
@onready var bot_hero_button = %BotHeroButton
@onready var fast_forward_button: Button = $MarginContainer/VB/FastForwardButton
@onready var battle_log_entries = %BattleLogEntries
@onready var wait_time_slider = %WaitTimeSlider
@onready var wait_time_label = %WaitTimeLabel

var selected_hero: Hero
var selected_lane_manager_component: LaneManagerComponent
var selected_state_machine_component: StateMachineComponent
var selected_heroes_controller_component: ControllerComponent
var selected_heroes_attack_component: AttackComponent
var selected_heroes_target_Outline: OutlineComponent
var selected_outline_component: OutlineComponent
var top_hero_res: HeroResource
var bot_hero_res: HeroResource
var top_hero_node: CharacterBody2D
var bot_hero_node: CharacterBody2D
var top_lane := true
var bot_lane := false
var current_target_outline_component: OutlineComponent

func _ready():
	call_deferred("update")
	SignalManager.event.connect(event_happend)
	SignalManager.on_battle_end.connect(on_battle_end)
	SignalManager.restart_match.connect(show_battle_manager)
	
	await get_tree().physics_frame
	if TeamManager.bot == null and TeamManager.top == null:
		hide()

func _process(_delta):
	if is_instance_valid(selected_hero):
		if selected_heroes_attack_component != null:
			if selected_heroes_attack_component.current_target_hurtbox != null:
				var target_node = selected_heroes_attack_component.current_target_hurtbox.get_parent()
				if current_target_outline_component != selected_heroes_target_Outline:
					current_target_outline_component.remove_outline()
				
				var target_enemy
				
				for child in target_node.get_children():
					if child is StatsComponent:
						target_enemy = child.enemy
					
				for child in target_node.get_children():
					if child is OutlineComponent:
						if child == selected_outline_component:
							return
							
						current_target_outline_component = child
						if target_enemy:
							child.apply_outline(child.OUTLINE_TYPE.TARGET)
						else:
							child.apply_outline(child.OUTLINE_TYPE.FRIENDLY)
		

func on_battle_end(_win: bool) -> void:
	for child in battle_log_entries.get_children():
		child.queue_free()
	
func event_happend(actor: PhysicsBody2D, killer: PhysicsBody2D) -> void:
	#to show minion kill in log, # below
	if actor is Minion:
		return
		
	var new_battlelog = log_scene.instantiate()
	battle_log_entries.add_child(new_battlelog)
	battle_log_entries.move_child(new_battlelog, 0)
	new_battlelog.new_log(actor.actor_name, killer.actor_name)
	
	for child in actor.get_children():
		if child is StatsComponent:
			if child.enemy:
				new_battlelog.set_colors_bully_dead()
			else:
				new_battlelog.set_colors_buddy_dead()

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
	else:
		bot_hero_button.flat = false

func handle_hero_chosen() -> void:
	selected_lane_manager_component = selected_hero.get_lane_manager_component()
	selected_state_machine_component = selected_hero.get_state_machine_component()
	selected_heroes_controller_component = selected_hero.get_controller_component()
	selected_heroes_controller_component.listen_to_orders = true
	selected_heroes_attack_component = selected_hero.get_attack_component()
	selected_outline_component = selected_hero.get_outline_component()
	selected_outline_component.apply_outline(selected_outline_component.OUTLINE_TYPE.SELF)

func deselect_hero() -> void:
	if selected_outline_component != null:
		selected_outline_component.remove_outline()
		
	if current_target_outline_component != null:
		current_target_outline_component.remove_outline()
	
	if selected_heroes_controller_component != null:
		selected_heroes_controller_component.listen_to_orders = false
	
	selected_hero = null
	selected_state_machine_component = null
	top_hero_button.flat = true
	bot_hero_button.flat = true


func _on_top_hero_button_pressed():
	if selected_hero == top_hero_node:
		deselect_hero()
		return
	
	deselect_hero()
	switch_active_button(top_lane)
	selected_hero = top_hero_node
	handle_hero_chosen()

func _on_bot_hero_button_pressed():
	if selected_hero == bot_hero_node:
		deselect_hero()
		return
	
	deselect_hero()
	switch_active_button(bot_lane)
	selected_hero = bot_hero_node
	handle_hero_chosen()
	
func _on_top_button_pressed():
	if selected_state_machine_component != null:
		selected_lane_manager_component.on_lane_change(top_lane)

func _on_bot_button_pressed():
	if selected_state_machine_component != null:
		selected_lane_manager_component.on_lane_change(bot_lane)

func _on_retreat_button_pressed() -> void:
	if selected_state_machine_component != null:
		selected_state_machine_component.on_child_transition("RetreatState")

func show_battle_manager() -> void:
	show()

func _on_fast_forward_button_pressed() -> void:
	var homepage = get_tree().get_first_node_in_group("homepage") as Homepage
	if homepage.has_method("set_fast_forward"):
		homepage.set_fast_forward()


func _on_end_battle_button_pressed():
	SignalManager.on_battle_end.emit(true)


func _on_shake_button_pressed():
	var canvas_ref = get_tree().get_first_node_in_group("canvas")
	canvas_ref.apply_noise_shake()


func _on_wait_time_slider_value_changed(value):
	if value == 5:
		wait_time_label.text = "∞"
	else:
		wait_time_label.text = str(value) + " seconds"
		
	SignalManager.manual_wait_time_changed.emit(value)

func _on_leave_manual_button_pressed():
	selected_state_machine_component.on_child_transition("TransitionState")
