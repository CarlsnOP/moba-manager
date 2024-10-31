extends PanelContainer

@onready var skill_texture: TextureRect = %SkillTexture

var skill: SkillResource = null

func set_skill(heroes_skill: SkillResource):
	skill = heroes_skill
	skill_texture.texture = skill.icon

func _on_mouse_entered() -> void:
	if skill == null:
		return
		
	Popups.show_skill_popup(Rect2i( Vector2i(global_position), Vector2i(size)), skill)

func _on_mouse_exited() -> void:
	Popups.hide_skill_popup()
