extends Control

@export var log_scene: PackedScene

@onready var vb = %VB

var log_entries: Array

func _ready():
	SignalManager.rubberduckies_created.connect(rubberduckies_created)

func rubberduckies_created(amount: int) -> void:

	var new_log = log_scene.instantiate()
	vb.add_child(new_log)
	new_log.add_to_group("log")
	new_log.new_log(amount)
	log_entries.append(new_log)
	remove_entry()
	
func remove_entry() -> void:
	if len(log_entries) < 5:
		return
	
	var entry_to_remove = log_entries[0]
	log_entries.remove_at(0)
	entry_to_remove.queue_free()
