class_name State
extends Node


signal on_child_transition(state: State, new_state_name: String)


func enter(hero: CharacterBody2D, nav: NavigationAgent2D):
	pass

func exit():
	pass

func update(_delta: float):
	pass

func physics_Update(_delta: float):
	pass
