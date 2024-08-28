extends PanelContainer

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

func _ready():
	SignalManager.new_interface.connect(new_interface)
	hide()

func new_interface(_state) -> void:
	if visible:
		hide()

		
func setup(n: String, lvl: int, xp: int, up: int, hp: float, dmg: float, ap: float, icon: CompressedTexture2D, type: String, lore: String):
	name_label.text = n
	name_2_label.text = n
	lvl_label.text = "Level: %s" % lvl
	xp_label.text = "Experience: %s" % xp
	upgrade_points_label.text = "Upgrade points: %s" % up
	health_label.text = "Health: %s" % hp
	damage_label.text = "Attack Damage: %s" % dmg
	ability_power_label.text = "Ability Power: %s" % ap
	type_label.text = type
	lore_label.text = lore
	texture_rect.texture = icon
