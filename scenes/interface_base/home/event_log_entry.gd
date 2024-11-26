extends Control

@onready var loot_grid: LootGrid = %LootGrid
@onready var result_label: Label = %ResultLabel
@onready var match_length_label: Label = %MatchLengthLabel
@onready var team_hb: HBoxContainer = %TeamHB
@onready var exp_label: Label = %ExpLabel
@onready var currency_label: Label = %CurrencyLabel

@export var hero_slot_scene: PackedScene

var loot_scale := Vector2(0.5, 0.5)
var elapsed_time: int


func _ready() -> void:
	var map = get_tree().get_first_node_in_group("map")
	
	if map.has_method("get_game_length"):
		elapsed_time = map.get_game_length()
	
	set_match_time()
	exp_label.text += str(RewardManager._exp_gained)
	currency_label.text += str(RewardManager._rubberduckies_gained)
	loot_grid.display(RewardManager._loot_gained)
	instantiate_friendly_team()

func set_match_time() -> void:
	var minutes = elapsed_time / 60
	var seconds = elapsed_time % 60
	match_length_label.text = "%02d:%02d" % [minutes, seconds]

func set_result_label(win: bool) -> void:
	if win:
		result_label.text = "WIN!"
		result_label.modulate = Color.GREEN
	else:
		result_label.text = "LOST!"
		result_label.modulate = Color.RED

func instantiate_friendly_team() -> void:
	instantiate_friendly_top()
	instantiate_friendly_bot()

func instantiate_friendly_top() -> void:
	var top_hero = TeamManager.top
	var slot = hero_slot_scene.instantiate()
	team_hb.add_child(slot)
	slot.display(top_hero)

func instantiate_friendly_bot() -> void:
	var bot_hero = TeamManager.bot
	var slot = hero_slot_scene.instantiate()
	team_hb.add_child(slot)
	slot.display(bot_hero)
