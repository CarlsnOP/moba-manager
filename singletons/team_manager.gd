extends Node

enum LANE_SELECTED { TOP, MID, BOT, BOT2, JUNGLE}

@export var hero_list: HeroListResource = preload("res://resources/heroes/resources/hero_list.tres")

var _lane: LANE_SELECTED = LANE_SELECTED.TOP

var top: HeroResource = preload("res://resources/heroes/resources/egon.tres")
var mid: HeroResource = preload("res://resources/heroes/resources/todd.tres")
var bot: HeroResource = preload("res://resources/heroes/resources/em.tres")
var bot2: HeroResource = preload("res://resources/heroes/resources/lucy.tres")
var jungle: HeroResource = preload("res://resources/heroes/resources/eddy.tres")


func load_team():
	for heroes in hero_list.heroes:
		heroes.in_team = false
		top.in_team = true
		mid.in_team = true
		bot.in_team = true
		bot2.in_team = true
		jungle.in_team = true

func setup_team(hero: HeroResource) -> void:
	match _lane:
		LANE_SELECTED.TOP:
			top.in_team = false
			top = hero
			hero.in_team = true
		LANE_SELECTED.MID:
			mid.in_team = false
			mid = hero
			hero.in_team = true
		LANE_SELECTED.BOT:
			bot.in_team = false
			bot = hero
			hero.in_team = true
		LANE_SELECTED.BOT2:
			bot2.in_team = false
			bot2 = hero
			hero.in_team = true
		LANE_SELECTED.JUNGLE:
			jungle.in_team = false
			jungle = hero
			hero.in_team = true
