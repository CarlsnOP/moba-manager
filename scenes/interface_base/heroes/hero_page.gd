extends PanelContainer

#labels
@onready var name_label = %NameLabel
@onready var lvl_label = %LvlLabel
@onready var xp_label = %XPLabel
@onready var upgrade_points_label = %UpgradePointsLabel
@onready var health_label = %HealthLabel
@onready var damage_label = %DamageLabel
@onready var ability_power_label = %AbilityPowerLabel
@onready var name_2_label = %Name2Label
@onready var type_label = %TypeLabel
@onready var lore_label = %LoreLabel
@onready var texture_rect = %TextureRect
#buttons
@onready var hp_button = %HpButton
@onready var dmg_button = %DmgButton
@onready var ap_button = %ApButton

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
	lvl_label.text = "Level: %s" % hero.lvl
	xp_label.text = "Experience: %s" % hero.xp
	upgrade_points_label.text = "Upgrade points: %s" % hero.upgrade_points
	health_label.text = "Health: %s" % hero.health
	damage_label.text = "Attack Damage: %s" % hero.attack_damage
	ability_power_label.text = "Ability Power: %s" % hero.ability_power
	type_label.text = hero.type
	lore_label.text = hero.lore
	texture_rect.texture = hero.hero_icon

func _on_hp_button_pressed():
	_hero.health += _hero.extra_hp
	health_label.text = "Health: %s" % _hero.health

func _on_dmg_button_pressed():
	_hero.attack_damage += _hero.extra_ad
	damage_label.text = "Attack Damage: %s" % _hero.attack_damage

func _on_ap_button_pressed():
	_hero.ability_power += _hero.extra_ap
	ability_power_label.text = "Ability Power: %s" % _hero.ability_power
