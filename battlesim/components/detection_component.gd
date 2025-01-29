class_name DetectionComponent
extends Area2D


var detected_enemies := []


func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area):
	if area is HurtboxComponent:
		detected_enemies.append(area)

func _on_area_exited(area):
	if area is HurtboxComponent:
		detected_enemies.erase(area)
