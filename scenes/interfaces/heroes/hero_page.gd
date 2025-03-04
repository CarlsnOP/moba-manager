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
@onready var attack_speed_label = %AttackSpeedLabel
@onready var movement_speed_label = %MovementSpeedLabel
@onready var attack_range_label = %AttackRangeLabel
@onready var hp_reg_label = %HpRegLabel
@onready var lore_pc = %LorePC
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
		
		setup_labels()

func setup_labels() -> void:
	for h in StatsManager.hero_specific_stats:
			if h["hero"] == _hero:
				health_label.text = "Health: %s" % str(h["health"])
				hp_reg_label.text = "Health Regeneration: %s" % str(h["health_reg"])
				damage_label.text = "Attack Damage: %s" % str(h["damage"])
				ability_power_label.text = "Ability Power: %s" % str(h["ability_power"])
				dodge_label.text = "Dodge chance: " +  str(h["dodge"] * 100) + "%"
				block_label.text = "Block chance: " +  str(h["block"] * 100) + "%"
				crit_label.text = "Crit chance: " +  str(h["crit"] * 100) + "%"
				movement_speed_label.text = "Movement speed: " + str(h["move_speed"])
				attack_speed_label.text = "Attack speed: " + str(h["att_speed"])
				attack_range_label.text = "Attack range: " + str(h["att_range"])

func _on_lore_pc_mouse_entered():
	Popups.show_specific_popup(Rect2i( Vector2i(lore_pc.global_position), Vector2i(lore_pc.size)), _hero.lore)


func _on_lore_pc_mouse_exited():
		Popups.hide_popup()
