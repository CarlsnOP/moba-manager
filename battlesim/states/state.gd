class_name State
extends Node

const ALLY_TOO_FAR_AWAY := 80.0

signal on_child_transition(state: State, new_state_name: String)

#Varibles needed in different states
var possible_targets: Array[Node] = []
var possible_friendlies: Array[Node] = []
var lane_group: String
var nearest_friendly_distance = INF
var closest_ally: Vector2

func enter():
	pass

func exit():
	pass

func update(_delta: float):
	pass

func physics_Update(_delta: float):
	pass
