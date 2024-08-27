extends PanelContainer


@onready var texture_rect = %TextureRect
@onready var name_label = %NameLabel


var _hero: HeroResource

func display(hero: HeroResource) -> void:
	texture_rect.texture = hero.hero_icon
	name_label.text = "%s - lvl: 1" % hero.hero_name
	_hero = hero

func _on_button_pressed():
	SignalManager.hero_selected.emit(_hero)
