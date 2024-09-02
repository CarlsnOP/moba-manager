extends PanelContainer

@export var icon: bool

@onready var texture_rect = %TextureRect
@onready var name_label = %NameLabel


var _hero: HeroResource

func display(hero: HeroResource) -> void:
	if icon:
		texture_rect.texture = hero.hero_icon
	else:
		texture_rect.texture = hero.hero_portrait
	name_label.text = "%s - lvl: 1" % hero.hero_name
	_hero = hero

func picked() -> void:
	if !icon:
		queue_free()

func _on_button_pressed():
	if icon:
		SignalManager.on_hero_selected.emit(_hero)
	else:
		SignalManager.on_portrait_selected.emit(_hero)
