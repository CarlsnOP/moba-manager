extends CharacterBody2D


enum TEAM { BUDDY, BULLY }


@export_category("Stats:")
@export var team: TEAM
@export var move_speed := 90.0
@export var _att_speed := 1.0
@export var _initial_state: State
@export var _initial_lane: LaneState
@export var top: bool
@export var bot: bool
@export var jungler: bool

@onready var nav_agent = %NavAgent
@onready var health_bar = %HealthBar
@onready var att_timer = %AttTimer
@onready var state_machine = %StateMachine
@onready var lane_state_machine = %LaneStateMachine
@onready var sprite_2d = %Sprite2D
@onready var respawn_timer: Timer = %RespawnTimer
@onready var respawn_team: Marker2D = $"../RespawnTeam"
@onready var attack_range: Area2D = $AttackRange
@onready var debug_label: Label = $DebugLabel

var _target = null
var _attacker: Node2D = null
var _enemies_in_range := []
var current_state: State
var _hero: HeroResource

#Hero Stats
var _health: float
var _health_regen: float
var _damage: float
var _ability_power: float
var _dodge: float
var _block: float
var _crit: float
var _damage_reduction := 1.0

var _dead_pos := Vector2(0, 0)
var _respawn_time := 15.0


func _ready():
	setup()
	
func setup() -> void:
	if top:
		_hero = TeamManager.top
	if bot:
		_hero = TeamManager.bot
	if jungler:
		_hero = TeamManager.jungle
	sprite_2d.texture = _hero.hero_icon
	setup_hero_stats()
	health_bar.setup(_health, _health)
	att_timer.wait_time = _att_speed
	respawn_timer.wait_time = _respawn_time
	load_abilities()

func setup_hero_stats() -> void:
	if _hero.equipped_item != null:
		_health = (_hero.health + (_hero.lvl * _hero.extra_hp)) * _hero.equipped_item.item_hp
		_health_regen = (_hero.health_regen) * _hero.equipped_item.item_hp_regen
		_damage = (_hero.attack_damage + (_hero.lvl * _hero.extra_ad)) * _hero.equipped_item.item_ad
		_ability_power = (_hero.ability_power + (_hero.lvl * _hero.extra_ap)) * _hero.equipped_item.item_ap
		_dodge = _hero.dodge + _hero.equipped_item.item_dodge
		_block = _hero.block + _hero.equipped_item.item_block
		_crit = _hero.crit + _hero.equipped_item.item_crit
	else:
		_health = _hero.health + (_hero.lvl * _hero.extra_hp)
		_health_regen = _hero.health_regen
		_damage = _hero.attack_damage + (_hero.lvl * _hero.extra_ad)
		_ability_power = _hero.ability_power + (_hero.lvl * _hero.extra_ap)
		_dodge = _hero.dodge
		_block = _hero.block
		_crit = _hero.crit

func load_abilities() -> void:
	if _hero.skill.skill_scene != null:
		var hero_skill = _hero.skill.skill_scene.instantiate()
		add_child(hero_skill)

func new_game() -> void:
	queue_free()

func _process(_delta: float) -> void:
	update_debug()
	
func _physics_process(_delta):
	set_target()
	
func update_debug() -> void:
	var s = "State: %s \n" % state_machine.get_state()
	s += "Lane: %s \n" % lane_state_machine.get_state()
	debug_label.text = s

func set_target() -> void:
	if _target != null:
		return
	
	for enemy in _enemies_in_range:
		if enemy == null:
			pass
		else:
			_target = enemy
			att_timer.start()
	
	if _target == null:
		att_timer.stop()
	return

func deal_damage(dmg: float) -> void:
	if _target != null:
		if _target.has_method("take_damage"):
			var is_critical = randf() <= _crit
			if is_critical:
				dmg *= 2.0
			_target.take_damage(dmg, self)

func take_damage(dmg: float, attacker: Node2D) -> void:
	_attacker = attacker
	dmg * _damage_reduction
	
	var is_dodged = randf() <= _dodge
	if is_dodged:
		return
		
	var is_blocked = randf() <= _block
	if is_blocked:
		dmg *= 0.2
	
	health_bar.take_damage(dmg)

func die() -> void:
	set_physics_process(false)
	state_machine.on_death()
	global_position = _dead_pos
	respawn_timer.start()

func respawn(health: float) -> void:
	respawn_timer.stop()
	global_position = respawn_team.global_position
	health_bar.setup(_health, health)
	state_machine.on_respawn()
	set_physics_process(true)

func set_dmg_red(dmg_red: float) -> void:
	_damage_reduction += dmg_red

func _on_attack_range_body_entered(body):
	if body.is_in_group("jungle") and jungler:
		_enemies_in_range.append(body)
		
	if body.is_in_group("bully"):
		_enemies_in_range.append(body)

func _on_attack_range_body_exited(body):
	if _enemies_in_range.has(body):
		_enemies_in_range.erase(body)

	if _target == body:
		_target = null

func _on_att_timer_timeout():
	deal_damage(_damage)

func _on_health_bar_died():
	var current_pos = global_position
	die()
	SignalManager.friendly_hero_died.emit(_hero, self, current_pos)

func get_res() -> HeroResource:
	return _hero

func get_initial_state() -> State:
	return _initial_state

func get_initial_lane() -> LaneState:
	return _initial_lane

func get_minion_array() -> Array[PathFollow2D]:
	return lane_state_machine.get_minion_array()

func get_jungle_array() -> Array:
	return lane_state_machine.get_jungle_array()

func _on_respawn_timer_timeout() -> void:
	respawn(_health)
