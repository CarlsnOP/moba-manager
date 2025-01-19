extends PanelContainer

signal hero_selected(HeroResource)

@export var icon: bool

@onready var texture_rect = %TextureRect
@onready var name_label = %NameLabel
@onready var xp_progress_bar: ProgressBar = %XpProgressBar

var _hero: HeroResource

func display(hero: HeroResource) -> void:
	if icon:
		texture_rect.texture = hero.hero_icon
	else:
		texture_rect.texture = hero.hero_portrait
		name_label.hide()
	name_label.text = "%s - lvl: %s" % [hero.hero_name, hero.lvl]
	_hero = hero

func update() -> void:
	update_label()
	update_xp_progressbar()

func update_label() -> void:
	name_label.text = "%s - lvl: %s" % [_hero.hero_name, _hero.lvl]

func update_xp_progressbar() -> void:
	var current_level = _hero.lvl
	var current_xp = _hero.xp
	var current_threshold = 0
	var next_threshold = LevelManager.exp_thresholds[current_level - 1]
	
	if current_level > 1:
		current_threshold = LevelManager.exp_thresholds[current_level - 2]
		
	xp_progress_bar.min_value = current_threshold
	xp_progress_bar.max_value = next_threshold
	xp_progress_bar.value = current_xp

func scale_slot(scale_size: Vector2) -> void:
	scale = scale_size

func _on_button_pressed():
	if icon:
		SignalManager.on_hero_selected.emit(_hero)
	else:
		hero_selected.emit(_hero)
