extends CharacterBody2D

@export_category("Stats:")
@export var _health := 200.0
@export var _damage := 75.0
@export var _ability_power := 30
@export var _move_speed := 90.0
@export var _att_speed := 1.0
@export var _initial_state: State
@export var _initial_lane: LaneState

@onready var health_bar = %HealthBar
@onready var att_timer = %AttTimer
@onready var lane_state_machine = %LaneStateMachine
@onready var nav_agent = $NavAgent


func get_initial_state() -> State:
	return _initial_state

func get_initial_lane() -> LaneState:
	return _initial_lane

func get_minion_array() -> Array[PathFollow2D]:
	return lane_state_machine.get_minion_array()
