extends Control

@export var log_scene: PackedScene

@onready var vb = %VB

var log_entries: Array = []

func _ready():
	SignalManager.rubberduckies_created.connect(rubberduckies_created)
	SignalManager.on_log_entry.connect(on_log_entry)

func on_log_entry(node) -> void:
	log_entries.append(node)
	remove_entry()

func rubberduckies_created(amount: int) -> void:
	var new_log = log_scene.instantiate()
	vb.add_child(new_log)
	new_log.new_log(amount)
	log_entries.append(new_log)
	remove_entry()
	
func remove_entry() -> void:
	var valid_entries = []
	print(log_entries)
	for entry in log_entries:
		if entry != null:
			valid_entries.append(entry)
			log_entries = valid_entries

	if len(log_entries) < 5:
		return

	var entry_to_remove = log_entries[0]
	log_entries.remove_at(0)

	if entry_to_remove != null:
		entry_to_remove.queue_free()
