extends Control

@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var AMBIENCE_BUS_ID = AudioServer.get_bus_index("Ambience")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var UI_BUS_ID = AudioServer.get_bus_index("UI")
@onready var mode_button = %ModeButton
@onready var resolution_button = %ResolutionButton
@onready var master_slider: HSlider = %MasterSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var ambience_slider = %AmbienceSlider
@onready var sfx_slider: HSlider = %SFXSlider
@onready var ui_slider = %UISlider
@onready var master_volume_label = %MasterVolumeLabel
@onready var music_volume_label = %MusicVolumeLabel
@onready var ambience_volume_label = %AmbienceVolumeLabel
@onready var sfx_volume_label = %SFXVolumeLabel
@onready var ui_volume_label = %UIVolumeLabel
@onready var mute_master_button = %MuteMasterButton
@onready var mute_music_button = %MuteMusicButton
@onready var mute_ambience_button = %MuteAmbienceButton
@onready var mute_sfx_button = %MuteSFXButton
@onready var mute_ui_button = %MuteUIButton

func _ready():
	#Set Master volume to 25 % and music at 50 % on first launch... Your welcome
	master_slider.value = 0.25
	music_slider.value = 0.5

#Display Settings		
func _on_mode_button_item_selected(index):
	_on_resolution_button_item_selected(resolution_button.selected)
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			resolution_button.disabled = true
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			resolution_button.disabled = false
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
			resolution_button.disabled = false

func _on_resolution_button_item_selected(index):
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920,1080))
		1:
			DisplayServer.window_set_size(Vector2i(1600, 900))
		2:
			DisplayServer.window_set_size(Vector2i(1280, 720))
		
#Audio Settings
func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MASTER_BUS_ID, value < .05)
	var percentage_value = int(value * 100)
	master_volume_label.text = str(percentage_value) + " %"
	if AudioServer.is_bus_mute(0):
		mute_master_button.button_pressed = true
	else:
		mute_master_button.button_pressed = false

func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < .05)
	var percentage_value = int(value * 100)
	music_volume_label.text = str(percentage_value) + " %"
	if AudioServer.is_bus_mute(1):
		mute_music_button.button_pressed = true
	else:
		mute_music_button.button_pressed = false

func _on_ambience_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AMBIENCE_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(AMBIENCE_BUS_ID, value < .05)
	var percentage_value = int(value * 100)
	ambience_volume_label.text = str(percentage_value) + " %"
	if AudioServer.is_bus_mute(3):
		mute_ambience_button.button_pressed = true
	else:
		mute_ambience_button.button_pressed = false

func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < .05)
	var percentage_value = int(value * 100)
	sfx_volume_label.text = str(percentage_value) + " %"
	if AudioServer.is_bus_mute(3):
		mute_sfx_button.button_pressed = true
	else:
		mute_sfx_button.button_pressed = false

func _on_ui_slider_value_changed(value):
	AudioServer.set_bus_volume_db(UI_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(UI_BUS_ID, value < .05)
	var percentage_value = int(value * 100)
	ui_volume_label.text = str(percentage_value) + " %"
	if AudioServer.is_bus_mute(4):
		mute_ui_button.button_pressed = true
	else:
		mute_ui_button.button_pressed = false

func _on_mute_master_button_toggled(_toggled_on):
	if AudioServer.is_bus_mute(0):
		AudioServer.set_bus_mute(MASTER_BUS_ID, false)
	else:
		AudioServer.set_bus_mute(MASTER_BUS_ID, true)

func _on_mute_music_button_toggled(_toggled_on):
	if AudioServer.is_bus_mute(1):
		AudioServer.set_bus_mute(MUSIC_BUS_ID, false)
	else:
		AudioServer.set_bus_mute(MUSIC_BUS_ID, true)

func _on_mute_ambience_button_toggled(_toggled_on):
	if AudioServer.is_bus_mute(2):
		AudioServer.set_bus_mute(AMBIENCE_BUS_ID, false)
	else:
		AudioServer.set_bus_mute(AMBIENCE_BUS_ID, true)
		
func _on_mute_sfx_button_toggled(_toggled_on):
	if AudioServer.is_bus_mute(3):
		AudioServer.set_bus_mute(SFX_BUS_ID, false)
	else:
		AudioServer.set_bus_mute(SFX_BUS_ID, true)

func _on_mute_ui_button_toggled(_toggled_on):
	if AudioServer.is_bus_mute(4):
		AudioServer.set_bus_mute(UI_BUS_ID, false)
	else:
		AudioServer.set_bus_mute(UI_BUS_ID, true)

#Save function
func on_save_game(saved_data: Array[SavedData]) -> void:
	var my_data = SavedSettingsData.new()
	my_data.scene_path = scene_file_path
	if get_parent():
		my_data.parent_path = get_parent().get_path()
	#Display
	my_data.window_mode = DisplayServer.window_get_mode()
	my_data.window_flag = DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS)
	my_data.resolution_button = resolution_button.selected
	#Audio
	my_data.master_volume = master_slider.value
	my_data.music_volume = music_slider.value
	my_data.ambience_volume = ambience_slider.value
	my_data.sfx_volume = sfx_slider.value
	my_data.ui_volume = ui_slider.value
	saved_data.append(my_data)

func _on_quit_button_pressed():
	SignalManager.new_interface.emit(InterfaceManager.INTERFACE_STATE.BATTLESIM)

#Load function
func on_before_load_game():
	get_parent().remove_child(self)
	queue_free()
	
func on_load_game(saved_data: SavedData) -> void:
	if saved_data is SavedSettingsData:
		#Display
		match saved_data.window_mode:
			0:
				if saved_data.window_flag == 0:
					_on_mode_button_item_selected(1)
					mode_button.select(1)
				else:
					_on_mode_button_item_selected(2)
					mode_button.select(2)
			3:
				_on_mode_button_item_selected(0)
				mode_button.select(0)
		
		_on_resolution_button_item_selected(saved_data.resolution_button)
		resolution_button.selected = saved_data.resolution_button
		
		#Audio
		master_slider.value = saved_data.master_volume
		music_slider.value = saved_data.music_volume
		ambience_slider.value = saved_data.ambience_volume
		sfx_slider.value = saved_data.sfx_volume
		ui_slider.value = saved_data.ui_volume

		var parent_scene = get_node(saved_data.parent_path)
		get_parent().remove_child(self)
		parent_scene.add_child(self)
		get_parent().reassign_settings(self)
		
		hide()
