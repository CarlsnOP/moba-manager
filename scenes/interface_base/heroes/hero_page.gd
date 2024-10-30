extends PanelContainer

#labels
@onready var name_label = %NameLabel
@onready var lvl_label = %LvlLabel
@onready var xp_label = %XPLabel
@onready var xp_progress_bar: ProgressBar = %XpProgressBar
@onready var upgrade_points_label = %UpgradePointsLabel
@onready var health_label = %HealthLabel
@onready var damage_label = %DamageLabel
@onready var ability_power_label = %AbilityPowerLabel
@onready var skill: TextureRect = %Skill
@onready var name_2_label = %Name2Label
@onready var type_label = %TypeLabel
@onready var lore_label = %LoreLabel
@onready var texture_rect = %TextureRect

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
	#Labels
	name_label.text = hero.hero_name
	name_2_label.text = hero.hero_name
	update()
	upgrade_points_label.text = "Upgrade points: %s" % hero.upgrade_points
	health_label.text = "Health: %s" % str(hero.health + (hero.lvl * hero.extra_hp))
	damage_label.text = "Attack Damage: %s" % str(hero.attack_damage + (hero.lvl * hero.extra_ad))
	ability_power_label.text = "Ability Power: %s" % str(hero.ability_power + (hero.lvl * hero.extra_ap))
	skill.tooltip_text = ""
	type_label.text = hero.type
	lore_label.text = hero.lore
	texture_rect.texture = hero.hero_icon

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
