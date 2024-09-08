class_name LaneState
extends Node

var minions: Array[PathFollow2D] = []

signal on_child_transition(state: LaneState, new_state_name: String)

func enter():
	pass

func exit():
	pass

func update(_delta: float):
	pass

func physics_Update(_delta: float):
	pass

func _on_minion_added(child):
	if child is PathFollow2D:
		minions.append(child)

func _on_minion_removed(child):
	if child is PathFollow2D:
		minions.erase(child)
