extends Control

@export var event_log_scene: PackedScene

@onready var event_log_entries: VBoxContainer = %EventLogEntries

var log_entries: Array = []

func _ready():
	SignalManager.on_battle_end.connect(on_battle_end)


func on_battle_end(win: bool) -> void:
	create_event_log(win)
	
	
func create_event_log(win: bool) -> void:
	var xp = str(RewardManager._exp_gained)
	var currency = str(RewardManager._rubberduckies_gained)
	var loot = RewardManager._loot_gained
	var top_hero = TeamManager.top
	var bot_hero = TeamManager.bot
	

		
	var new_eventlog = event_log_scene.instantiate()
	event_log_entries.add_child(new_eventlog)
	event_log_entries.move_child(new_eventlog, 0)
	new_eventlog.setup(xp, currency, loot)
	new_eventlog.set_match_time(MatchDataManager.previous_game_elapsed_time)
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
	
	my_data.save_time = int(Time.get_unix_time_from_system())
	my_data.last_reward_amount = RewardManager.loot_gained_last_game
	
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
				#event_log_entries.move_child(new_eventlog, 0)
				new_eventlog.set_result_label(child["Win"])
				new_eventlog.set_match_time(child["Match_time"])
				new_eventlog.setup(
					child["Exp"],
					child["Currency"],
					child["Loot"],)
				new_eventlog.instantiate_friendly_top(child["Top"])
				new_eventlog.instantiate_friendly_bot(child["Bot"])
				on_log_entry(new_eventlog)
				
		var new_time := int(Time.get_unix_time_from_system())
		RewardManager.loot_gained_last_game = saved_data.last_reward_amount
		
		if new_time > saved_data.save_time:
			var calc_time_difference_in_minutes = (new_time - saved_data.save_time) / 60
			var amount_of_games = calc_time_difference_in_minutes / 5
			var offline_rewards = round((amount_of_games * saved_data.last_reward_amount) * 0.2)
			var offline_loot: Array[LootResource] = FunctionWizard.Create_loot_reward(offline_rewards)
			
			if offline_loot.size() > 0:
				ObjectMakerManager.instantiate_offline_reward_scene(DataStorage.OFFLINE_REWARDS, offline_loot)
		
	hide()
		

func _on_quit_button_pressed():
	SignalManager.new_interface.emit(InterfaceManager.INTERFACE_STATE.BATTLESIM)
