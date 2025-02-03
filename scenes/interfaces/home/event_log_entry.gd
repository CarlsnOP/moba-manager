extends Control

@onready var loot_grid: LootGrid = %LootGrid
@onready var result_label: Label = %ResultLabel
@onready var match_length_label: Label = %MatchLengthLabel
@onready var team_hb: HBoxContainer = %TeamHB
@onready var enemy_hb = %EnemyHB
@onready var exp_label: Label = %ExpLabel
@onready var currency_label: Label = %CurrencyLabel

@export var hero_slot_scene: PackedScene

var loot_scale := Vector2(0.5, 0.5)

var _won: bool
var elapsed_time: int
var _exp_gained: String
var _currency_gained: String
var _heroes_in_match: Array
var _deaths: Array
var _kills: Array
var _cs: Array
var _loot_received: Array[LootResource]

	
func setup(log_dict: Dictionary) -> void:
	_exp_gained = log_dict["xp"]
	exp_label.text += _exp_gained
	
	_currency_gained = log_dict["currency"]
	currency_label.text += _currency_gained
	
	_loot_received = log_dict["loot"]
	
	_kills = log_dict["kills"]
	_deaths = log_dict["deaths"]
	_cs = log_dict["cs"]
	
	loot_grid.display(_loot_received)
	if loot_grid.total_loot_slots < 19:
		custom_minimum_size.y = 500


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

func instantiate_heroes(heroes: Array) -> void:
	#prepare_save_data()
	_heroes_in_match = heroes
	var i = 0
	for hero in heroes:
		var slot = hero_slot_scene.instantiate()
		if i < 2:
			team_hb.add_child(slot)
			var stats_label = create_stats_label(i)
			team_hb.add_child(stats_label)
		else:
			enemy_hb.add_child(slot)
			var stats_label = create_stats_label(i)
			enemy_hb.add_child(stats_label)
			
		slot.display(hero)
		i += 1

#func prepare_save_data() -> void:
	#for hero in MatchDataManager.array_of_hero_dics:
		#_heroes_in_match.append(hero["hero_res"])
		#_kills.append(hero["kills"])
		#_deaths.append(hero["deaths"])
		#_cs.append(hero["cs"])

func create_stats_label(i: int) -> Label:
	var stats_label = Label.new()
	stats_label.text = "Kills: %s" % _kills[i] + "\n"
	stats_label.text += "Deaths: %s" % _deaths[i] + "\n"
	stats_label.text += "CS: %s" % _cs[i]
	return stats_label

#For saving data
func save_data() -> Dictionary:
	var log_data_dict = { 
		"win": _won,
		"match_time": elapsed_time,
		"xp": _exp_gained,
		"currency": _currency_gained,
		"heroes": _heroes_in_match,
		"kills": _kills,
		"deaths": _deaths,
		"cs": _cs,
		"loot": _loot_received
	}
	return log_data_dict
