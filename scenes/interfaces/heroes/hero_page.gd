extends PanelContainer

#labels
@onready var name_label = %NameLabel
@onready var lvl_label = %LvlLabel
@onready var xp_label = %XPLabel
@onready var xp_progress_bar: ProgressBar = %XpProgressBar
@onready var health_label = %HealthLabel
@onready var damage_label = %DamageLabel
@onready var ability_power_label = %AbilityPowerLabel
@onready var dodge_label: Label = %DodgeLabel
@onready var block_label: Label = %blockLabel
@onready var crit_label: Label = %CritLabel
@onready var name_2_label = %Name2Label
@onready var type_label = %TypeLabel
@onready var lore_label = %LoreLabel
@onready var texture_rect = %TextureRect
@onready var skill_slot: PanelContainer = %SkillSlot

var _hero: HeroResource
var hp_growth: float
var dmg_growth: float
var ap_growth: float

func _ready():
	SignalManager.new_interface.connect(new_interface)
	hide()

func new_interface(_state) -> void:
	if visible:
		hide()
		
func setup(hero: HeroResource):
	_hero = hero
	update()
	#Labels
	name_label.text = hero.hero_name
	name_2_label.text = "Name: %s" % hero.hero_name
	for h in StatsManager.hero_specific_stats:
		if h["hero"] == hero:
			health_label.text = "Health: %s" % str(h["health"])
			damage_label.text = "Attack Damage: %s" % str(h["damage"])
			ability_power_label.text = "Ability Power: %s" % str(h["health_reg"])
			dodge_label.text = "Dodge chance: " +  str(h["dodge"]) + "%"
			block_label.text = "Block chance: " +  str(h["block"]) + "%"
			crit_label.text = "Crit chance: " +  str(h["crit"]) + "%"
	type_label.text = "Type: %s" % hero.type
	lore_label.text = str(hero.lore)
	texture_rect.texture = hero.hero_icon
	#setup skill popup
	skill_slot.set_skill(hero.skill)

func update() -> void:
	if visible:
		lvl_label.text = "Level: %s" % _hero.lvl
		var current_level = _hero.lvl
		var current_xp = _hero.xp
		var current_threshold = 0
		var next_threshold = LevelManager.exp_thresholds[current_level - 1]
		
		if current_level > 1:
			current_threshold = LevelManager.exp_thresholds[current_level - 2]
			
		xp_progress_bar.min_value = current_threshold
		xp_progress_bar.max_value = next_threshold
		xp_progress_bar.value = current_xp
