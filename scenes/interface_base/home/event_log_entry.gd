extends Control

@onready var loot_grid: LootGrid = %LootGrid
@onready var result_label: Label = %ResultLabel
@onready var match_length_label: Label = %MatchLengthLabel
@onready var team_hb: HBoxContainer = %TeamHB
@onready var exp_label: Label = %ExpLabel
@onready var currency_label: Label = %CurrencyLabel

@export var hero_slot_scene: PackedScene

var loot_scale := Vector2(0.5, 0.5)

var _won: bool
var elapsed_time: int
var _exp_gained: String
var _currency_gained: String
var _top_hero: HeroResource
var _bot_hero: HeroResource
var _loot_received: Array[LootResource]

	
func setup(xp: String, currency: String, loot: Array[LootResource]) -> void:
	_exp_gained = xp
	exp_label.text += xp
	
	_currency_gained = currency
	currency_label.text += currency
	
	_loot_received = loot
	loot_grid.display(loot)

func set_match_time(time: int) -> void:
	elapsed_time = time
	var minutes = time / 60
	var seconds = time % 60
	match_length_label.text = "%02d:%02d" % [minutes, seconds]

func set_result_label(win: bool) -> void:
	if win:
		_won = win
		result_label.text = "WIN!"
		result_label.modulate = Color.GREEN
	else:
		_won = win
		result_label.text = "LOST!"
		result_label.modulate = Color.RED

func instantiate_friendly_top(hero: HeroResource) -> void:
	_top_hero = hero
	var slot = hero_slot_scene.instantiate()
	team_hb.add_child(slot)
	slot.display(hero)

func instantiate_friendly_bot(hero: HeroResource) -> void:
	_bot_hero = hero
	var slot = hero_slot_scene.instantiate()
	team_hb.add_child(slot)
	slot.display(hero)

#For saving data
func save_data() -> Dictionary:
	var log_data_dict = { 
		"Win": _won,
		"Match_time": elapsed_time,
		"Exp": _exp_gained,
		"Currency": _currency_gained,
		"Top": _top_hero,
		"Bot": _bot_hero,
		"Loot": _loot_received
	}
	return log_data_dict
