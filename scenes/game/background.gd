extends Sprite2D

var original_texture_size: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	if texture:
		original_texture_size = texture.get_size()
	
	get_viewport().connect("size_changed", Callable(self, "_on_viewport_size_changed"))
	
	_on_viewport_size_changed()

func _on_viewport_size_changed():
	if not texture:
		return
	
	var viewport_size = get_viewport().get_visible_rect().size
	
	var scale_x = viewport_size.x / original_texture_size.x
	var scale_y = viewport_size.y / original_texture_size.y
	
	scale = Vector2(scale_x, scale_y)
