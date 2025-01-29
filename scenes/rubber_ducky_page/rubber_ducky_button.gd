extends TextureButton


@onready var timer = %Timer
@onready var animation_player = %AnimationPlayer
@onready var pop_cpu_particles_2d = %PopCPUParticles2D
@onready var hero_shine_cpu_particles_2d = %HeroShineCPUParticles2D
@onready var hero_unlock_button = %HeroUnlockButton
@onready var unlocked_label = %UnlockedLabel


var duck_hitpoints := 5
var unlocked_hero: HeroResource

func _on_pressed():
	SoundManager.create_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.SQUEAK_SFX)
	if animation_player.is_playing():
		animation_player.play("RESET")
	animation_player.play("tapped")
	if timer.is_stopped():
		timer.start()
		
	duck_hitpoints -= 1
	
	if duck_hitpoints <= 0:
		pop_the_duck()
	
func pop_the_duck() -> void:
	disabled = true
	if animation_player.is_playing():
		animation_player.play("RESET")
	
	SoundManager.create_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.INFLATE_SFX)
	animation_player.play("pop")
	
	await animation_player.animation_finished
	
	unlocked_hero = get_random_hero()
	
	hero_unlock_button.texture_normal = unlocked_hero.hero_icon
	hero_unlock_button.show()
	
	texture_disabled = null
	texture_normal = null
	texture_focused = null
	
	animation_player.play("RESET")
	pop_cpu_particles_2d.emitting = true
	hero_shine_cpu_particles_2d.emitting = true
	SoundManager.create_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.POP_SFX)
	

func _on_timer_timeout():
	if duck_hitpoints < 5:
		duck_hitpoints += 1

func get_random_hero() -> HeroResource:
	var possible_hero_pool: Array
	for hero in TeamManager._all_heroes:
		if !hero.unlocked:
			possible_hero_pool.append(hero)
	
	unlocked_hero = possible_hero_pool[randi() % possible_hero_pool.size()]
	unlocked_hero.unlocked = true

	
	InventoryManager.spend_loot_ducky(1)
	
	return unlocked_hero

func _on_hero_unlock_button_pressed():
	hero_unlock_button.disabled = true
	
	SoundManager.create_ui_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.UNLOCK_HERO_SFX)
	unlocked_label.text = "Congrats!\n" + "You unlocked " + str(unlocked_hero.hero_name) + "!"
	var tween = get_tree().create_tween()
	tween.tween_property(hero_unlock_button, "modulate", Color("#FFFFFF"), 1.0).set_ease(tween.EASE_OUT)
	
	var tween2 = get_tree().create_tween()
	tween2.tween_property(unlocked_label, "modulate", Color("#FFFFFF"), 1.0).set_ease(tween.EASE_OUT)
	
	await get_tree().create_timer(3).timeout
	
	SignalManager.rubberduck_clicked.emit()
	
	get_tree().get_first_node_in_group("rubber_ducky_page").update()
	queue_free()
