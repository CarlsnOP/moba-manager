extends Control

const GREY_SCALE_MATERIAL = preload("res://effects/grey_scale_material.tres")

@onready var texture_rect = %TextureRect
@onready var kills_label = %KillsLabel
@onready var deaths_label = %DeathsLabel
@onready var respawn_label = %RespawnLabel
@onready var texture_progress_bar = %TextureProgressBar

var _hero: Dictionary
var _hero_node: PhysicsBody2D
var respawn_timer_ref: Timer
var original_texture_material: Material
var cooldown_timer_ref: Timer = null

func display(hero: Dictionary) -> void:
	SignalManager.event.connect(on_event)
	setup_vars(hero)
	update_labels()
	original_texture_material = texture_rect.material

func setup_vars(hero: Dictionary) -> void:
	set_process(false)
	_hero = hero
	_hero_node = hero["hero_node"] as Hero
	texture_rect.texture = hero["hero_portrait"]
	texture_progress_bar.setup(self)
	texture_progress_bar.texture_under = hero["hero_ability"]
	texture_progress_bar.texture_progress = hero["hero_ability"]
	
	respawn_label.hide()
	
	await get_tree().physics_frame
	for child in _hero_node.get_children():
			if child is DeathComponent:
				for c in child.get_children():
					if c.is_in_group("respawn_timer"):
						respawn_timer_ref = c
						respawn_timer_ref.timeout.connect(on_respawn)
			if child is AbilityComponent:
				for c in child.get_children():
					for possible_timer in c.get_children():
						if possible_timer.is_in_group("cooldown_timer"):
							cooldown_timer_ref = possible_timer
							texture_progress_bar.late_setup()
							
					

func _process(_delta):
	respawn_label.text = str(int(respawn_timer_ref.time_left))

func on_respawn() -> void:
	respawn_label.hide()
	set_process(false)
	texture_rect.material = original_texture_material

func update_labels() -> void:
	for hero in MatchDataManager.array_of_hero_dics:
		if hero == _hero:
			kills_label.text = "Kills: %s" % str(hero["kills"])
			deaths_label.text = "Deaths: %s" % str(hero["deaths"])

func on_event(actor: PhysicsBody2D, killer: PhysicsBody2D) -> void:
	if killer == _hero_node:
		update_labels()
	elif actor == _hero_node:
		update_labels()
		texture_rect.material = GREY_SCALE_MATERIAL
		respawn_label.show()
		set_process(true)
		
	else:
		return

func new_game() -> void:
	queue_free()
