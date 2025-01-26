extends Control


@export var loot_grid: LootGrid


func setup(offline_reward: Array[LootResource]) -> void:
		loot_grid.display(offline_reward)


func _on_texture_button_pressed():
	queue_free()
