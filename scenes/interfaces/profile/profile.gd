class_name ProfilePage
extends Control

@export var hero_slot_scene: PackedScene

@onready var hero_hb = %HeroHB
@onready var hero_label = %HeroLabel
@onready var hero_stats_label = %HeroStatsLabel
@onready var global_stats_label = %GlobalStatsLabel
@onready var global_hero_stats_label = %GlobalHeroStatsLabel
@onready var nickname_label = %NicknameLabel

var nickname: String

func _ready():	
	for hero in TeamManager._all_heroes:
		var slot = hero_slot_scene.instantiate()
		hero_hb.add_child(slot)
		slot.add_to_group("hero_buttons")
		slot.display(hero)
		slot.hero_selected.connect(setup_hero_specific_stats_label)
	
	stats_updated()

func stats_updated() -> void:
	setup_global_labels()
	setup_hero_specific_stats_label(hero_hb.get_child(0)._hero)

func setup_global_labels() -> void:
	#Generic Overall label
	global_stats_label.text = "Rubber Duck Multiplier: " + str(StatsManager.all_stats_multipliers["rubberduck_multiplier"] * 100) + "% \n"
	global_stats_label.text += "XP multiplier: " + str(StatsManager.all_stats_multipliers["xp_multiplier"] * 100) + "% \n"
	global_stats_label.text += "Loot multiplier: " + str(StatsManager.all_stats_multipliers["loot_multiplier"] * 100) + "% \n"
	
	#Generic Hero Stats Label
	global_hero_stats_label.text = "Max health multiplier: " + str(StatsManager.all_stats_multipliers["hp_multiplier"]) + "% \n"
	global_hero_stats_label.text += "Health Regen multiplier: " + str(StatsManager.all_stats_multipliers["hp_reg_multiplier"]) + "% \n"
	global_hero_stats_label.text += "Damage multiplier: " + str(StatsManager.all_stats_multipliers["damage_multiplier"]) + "% \n"
	global_hero_stats_label.text += "Ability Power multiplier: " + str(StatsManager.all_stats_multipliers["ap_multiplier"]) + "% \n"
	global_hero_stats_label.text += "Block multiplier: " + str(StatsManager.all_stats_multipliers["block_multiplier"]) + "% \n"
	global_hero_stats_label.text += "Dodge multiplier: " + str(StatsManager.all_stats_multipliers["dodge_multiplier"]) + "% \n"
	global_hero_stats_label.text += "Critical multiplier: " + str(StatsManager.all_stats_multipliers["crit_multiplier"]) + "% \n"
	
	
func setup_hero_specific_stats_label(hero: HeroResource) -> void:
	hero_label.text = hero.hero_name
	
	for h in StatsManager.hero_specific_stats:
		if h["hero"] == hero:
			hero_stats_label.text = "Max Health: " + str(h["health"]) + "\n"
			hero_stats_label.text += "Health regeneration: " + str(h["health_reg"]) + "\n"
			hero_stats_label.text += "Damage: " + str(h["damage"]) + "\n"
			hero_stats_label.text += "Ability power: " + str(h["ability_power"]) + "\n"
			hero_stats_label.text += "Block change: " + str(h["block"] * 100) + "%\n"
			hero_stats_label.text += "Dodge chance: " + str(h["dodge"] * 100) + "%\n"
			hero_stats_label.text += "Critical chance: " + str(h["crit"] * 100) + "%\n"
			
func set_nickname(nick: String) -> void:
	nickname = nick
	nickname_label.text = nick


func _on_quit_button_pressed():
	SignalManager.new_interface.emit(InterfaceManager.INTERFACE_STATE.BATTLESIM)
