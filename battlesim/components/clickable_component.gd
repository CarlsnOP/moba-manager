class_name ClickableComponent
extends Button

signal entity_clicked(node)

@export var actor: PhysicsBody2D

#Make this a child of Sprite 2d and fill to make entitiy clickable
func _ready():
	add_to_group("clickable_component")
	flat = true
	set_focus_mode(FOCUS_NONE)
	connect("pressed", Callable(self, "_on_pressed"))

func _on_pressed():
	entity_clicked.emit(actor)
