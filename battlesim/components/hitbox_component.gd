class_name HitboxComponent
extends Area2D

var targets_in_range := []


func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area):
	if area is HurtboxComponent:
		targets_in_range.append(area)

func _on_area_exited(area):
	if area is HurtboxComponent:
		targets_in_range.erase(area)
