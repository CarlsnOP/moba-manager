class_name HitboxComponent
extends Area2D

@export var stats_component: StatsComponent

var targets_in_range: Array = []

signal hit_hurtbox(hurtbox)
signal new_target_in_range()
signal target_in_range_removed()


func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
#
#func _on_hurtbox_entered(hurtbox: HurtboxComponent):
	#if !hurtbox is HurtboxComponent:
		#return
	#
	#hit_hurtbox.emit(hurtbox)
	#hurtbox.hurt.emit(self)

func _on_area_entered(area):
	if area is HurtboxComponent:
		targets_in_range.append(area)
		new_target_in_range.emit(area)

func _on_area_exited(area):
	if area is HurtboxComponent:
		targets_in_range.erase(area)
		target_in_range_removed.emit(area)
