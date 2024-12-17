extends Node

const LUCY = preload("res://resources/heroes/friendly/lucy.tres")

@onready var cooldown_timer: Timer = %CooldownTimer

@export var _cooldown: float

var allies := []
var respawn_health := 0.20
var ability_ready := true

func _ready() -> void:
	SignalManager.friendly_hero_died.connect(friendly_hero_died)
	cooldown_timer.wait_time = _cooldown

func friendly_hero_died(hero: HeroResource, node: Node2D, pos: Vector2) -> void:
	if hero != get_parent().get_res() and ability_ready:
		node.respawn(node._health * respawn_health)
		node.global_position = pos
		ability_ready = false
		cooldown_timer.start()

func _on_cooldown_timer_timeout() -> void:
	ability_ready = true
