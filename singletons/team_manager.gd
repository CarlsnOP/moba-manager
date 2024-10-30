extends Node

enum LANE_SELECTED { TOP, BOT, JUNGLE}

var _lane: LANE_SELECTED = LANE_SELECTED.TOP

var top: HeroResource = preload("res://resources/heroes/resources/egon.tres")
var bot: HeroResource = preload("res://resources/heroes/resources/em.tres")
var jungle: HeroResource = preload("res://resources/heroes/resources/eddy.tres")
var heroes_xp: Array[int] = []
var _all_heroes: Array[HeroResource] = []

func _ready():
	for file in DirAccess.get_files_at("res://resources/heroes/resources/"):
		var resource_file = "res://resources/heroes/resources/" + file
		var hero: HeroResource = load(resource_file) as HeroResource
		_all_heroes.append(hero)

func load_team():
	for heroes in _all_heroes:
		heroes.in_team = false
		top.in_team = true
		bot.in_team = true
		jungle.in_team = true

func setup_team(hero: HeroResource) -> void:
	match _lane:
		LANE_SELECTED.TOP:
			top.in_team = false
			top = hero
			hero.in_team = true
		LANE_SELECTED.BOT:
			bot.in_team = false
			bot = hero
			hero.in_team = true
		LANE_SELECTED.JUNGLE:
			jungle.in_team = false
			jungle = hero
			hero.in_team = true

func grant_current_team_exp(xp: int):
	top.xp += xp
	bot.xp += xp
	LevelManager.update_hero_levels()

#SAVE AND LOAD EXP ON HEROES
func get_hero_xp() -> Array[int]:
	heroes_xp.clear()
	
	for hero in _all_heroes:
		heroes_xp.append(hero.xp)
	return heroes_xp

func set_hero_xp(xp_list: Array[int]):
	if xp_list.size() != _all_heroes.size():
		return
	
	for hero in range(_all_heroes.size()):
		_all_heroes[hero].xp = xp_list[hero]
