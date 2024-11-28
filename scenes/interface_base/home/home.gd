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
	
	create_event_log(win)
	
	
func create_event_log(win: bool) -> void:
	var map = get_tree().get_first_node_in_group("map")
	var elapsed_time: int
	var xp = str(RewardManager._exp_gained)
	var currency = str(RewardManager._rubberduckies_gained)
	var loot = RewardManager._loot_gained
	var top_hero = TeamManager.top
	var bot_hero = TeamManager.bot
	
	
	if map.has_method("get_game_length"):
		elapsed_time = map.get_game_length()
		
	var new_eventlog = event_log_scene.instantiate()
	event_log_entries.add_child(new_eventlog)
	event_log_entries.move_child(new_eventlog, 0)
	new_eventlog.setup(xp, currency, loot)
	new_eventlog.set_match_time(elapsed_time)
	new_eventlog.set_result_label(win)
	new_eventlog.instantiate_friendly_top(top_hero)
	new_eventlog.instantiate_friendly_bot(bot_hero)
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
	if len(log_entries) < 6:
		return
#
	var entry_to_remove = log_entries[0]
	log_entries.remove_at(0)
#
	if entry_to_remove != null:
		entry_to_remove.queue_free()

#Saving function
func on_save_game(saved_data: Array[SavedData]):
	var my_data = SavedLogData.new()
	my_data.scene_path = scene_file_path
	if get_parent():
		my_data.parent_path = get_parent().get_path()
	
	for child in event_log_entries.get_children():
		var dict = child.save_data()
		my_data.log_data.append(dict)
		#remove_old_entry(my_data.log_data)
		
	saved_data.append(my_data)

#Loading function
func on_before_load_game():
	get_parent().remove_child(self)
	queue_free()

func on_load_game(saved_data:SavedData):
	if saved_data is SavedLogData:
		
		var parent_scene = get_node(saved_data.parent_path)
		get_parent().remove_child(self)
		parent_scene.add_child(self)
		
		get_parent().reassign_home(self)
		
		if saved_data.log_data is Array:
			for child in saved_data.log_data:
				var new_eventlog = event_log_scene.instantiate()
				event_log_entries.add_child(new_eventlog)
				event_log_entries.move_child(new_eventlog, 0)
				new_eventlog.set_result_label(child["Win"])
				new_eventlog.set_match_time(child["Match_time"])
				new_eventlog.setup(
					child["Exp"],
					child["Currency"],
					child["Loot"],)
				new_eventlog.instantiate_friendly_top(child["Top"])
				new_eventlog.instantiate_friendly_bot(child["Bot"])
				on_log_entry(new_eventlog)
		
		
