extends Control

@export var log_scene: PackedScene
@export var event_log_scene: PackedScene

@onready var battle_log_entries: VBoxContainer = %BattleLogEntries
@onready var event_log_entries: VBoxContainer = %EventLogEntries

var log_entries: Array = []

func _ready():
	SignalManager.friendly_hero_died.connect(friendly_hero_died)
	SignalManager.enemy_hero_died.connect(enemy_hero_died)
	SignalManager.tower_died.connect(tower_died)
	SignalManager.on_battle_end.connect(on_battle_end)

func friendly_hero_died(hero: HeroResource, node: Node2D, _pos: Vector2) -> void:
	var new_battlelog = log_scene.instantiate()
	battle_log_entries.add_child(new_battlelog)
	battle_log_entries.move_child(new_battlelog, 0)
	new_battlelog.new_log(hero.hero_name, node.attacked_by)
	new_battlelog.set_colors_buddy_dead()

func enemy_hero_died(node: Node2D):
	var new_battlelog = log_scene.instantiate()
	battle_log_entries.add_child(new_battlelog)
	battle_log_entries.move_child(new_battlelog, 0)
	new_battlelog.new_log(node.name_string, node._attacker)
	new_battlelog.set_colors_bully_dead()

func tower_died(tower: Node2D) -> void:
	#Bully
	if tower.team == 0:
		var new_battlelog = log_scene.instantiate()
		battle_log_entries.add_child(new_battlelog)
		battle_log_entries.move_child(new_battlelog, 0)
		new_battlelog.new_log("Enemy tower", tower.attacked_by)
		new_battlelog.set_colors_bully_dead()
		
	elif tower.team == 1:
		var new_battlelog = log_scene.instantiate()
		battle_log_entries.add_child(new_battlelog)
		battle_log_entries.move_child(new_battlelog, 0)
		new_battlelog.new_log("Friendly tower", tower.attacked_by)
		new_battlelog.set_colors_buddy_dead()

func on_battle_end(win: bool) -> void:
	for child in battle_log_entries.get_children():
		child.queue_free()
	
	var new_eventlog = event_log_scene.instantiate()
	event_log_entries.add_child(new_eventlog)
	event_log_entries.move_child(new_eventlog, 0)
	new_eventlog.set_result_label(win)
	on_log_entry(new_eventlog)
	
func on_log_entry(node) -> void:
	log_entries.append(node)
	remove_entry()
	
func remove_entry() -> void:
	var valid_entries = []
	#print(log_entries)
	for entry in log_entries:
		if entry != null:
			valid_entries.append(entry)
			log_entries = valid_entries
#
	if len(log_entries) < 11:
		return
#
	var entry_to_remove = log_entries[0]
	log_entries.remove_at(0)
#
	if entry_to_remove != null:
		entry_to_remove.queue_free()
