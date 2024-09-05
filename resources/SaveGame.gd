class_name SaveGame
extends Resource


const SAVE_GAME_PATH := "user://savegame.tres"

@export var rubber_duckies := 0

@export var heroes := Resource
@export var inventory: Resource

func write_savegame() -> void:
	ResourceSaver.save(self, SAVE_GAME_PATH)

static func load_savegame() -> Resource:
	if ResourceLoader.exists(SAVE_GAME_PATH):
		return load(SAVE_GAME_PATH)
	return null