extends Control

@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var fullscreen_button: CheckButton = %FullscreenButton
@onready var master_slider: HSlider = %MasterSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SFXSlider


#Display Settings
func _on_fullscreen_button_toggled(_toggled_on: bool) -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

#Audio Settings
func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MASTER_BUS_ID, value < .05)

func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < .05)

func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < .05)

#Save function
func on_save_game(saved_data: Array[SavedData]) -> void:
	var my_data = SavedAudioData.new()
	my_data.scene_path = scene_file_path
	if get_parent():
		my_data.parent_path = get_parent().get_path()
	my_data.master_volume = master_slider.value
	my_data.music_volume = music_slider.value
	my_data.sfx_volume = sfx_slider.value
	saved_data.append(my_data)

#Load function
func on_before_load_game():
	get_parent().remove_child(self)
	queue_free()
	
func on_load_game(saved_data: SavedData) -> void:
	if saved_data is SavedAudioData:
		master_slider.value = saved_data.master_volume
		music_slider.value = saved_data.music_volume
		sfx_slider.value = saved_data.sfx_volume

		var parent_scene = get_node(saved_data.parent_path)
		get_parent().remove_child(self)
		parent_scene.add_child(self)
		get_parent().reassign_settings(self)
		
		hide()
