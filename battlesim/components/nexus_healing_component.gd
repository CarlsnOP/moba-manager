class_name NexusHealingComponent
extends Area2D

signal on_heal(friend_pos: Vector2)

const HEAL_WAIT_TIME := 0.3

var friend_in_range: Array = []
var heal_timer: Timer = Timer.new()

func _ready():
	add_child(heal_timer)
	heal_timer.wait_time = HEAL_WAIT_TIME
	heal_timer.one_shot = true
	heal_timer.timeout.connect(heal_friend)
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _process(_delta):
	if heal_timer.is_stopped():
		if friend_in_range.size() >= 1:
			heal_timer.start()

func heal_friend() -> void:
	for friend in friend_in_range:
		var friends_parent = friend.get_parent()
		for child in friends_parent.get_children():
			if child is StatsComponent:
				if child.health < child.max_health:
					if friend.has_method("get_healed"):
						friend.get_healed(child.max_health / 10)
						on_heal.emit(friend.global_position)
				else:
					heal_timer.stop()


func _on_area_entered(area):
	if area is HurtboxComponent:
		friend_in_range.append(area)

func _on_area_exited(area):
	if area is HurtboxComponent:
		friend_in_range.erase(area)
