extends Node

#load game
signal on_log_entry(node)

#Menus
signal on_hero_selected(hero: String)
signal on_portrait_selected(hero: String)
signal new_interface(state: int)
signal item_picked(item: ItemResource)

#Currency
signal rubberduckies_updated
signal rubberduckies_created(quantity: int)
signal rubberduckies_spent(quantity: int)

#Battle
signal on_battle_end(win: bool)
signal on_jungle_clear()
signal on_jungle_respawn_enemy()
signal on_jungle_respawn_team()
signal friendly_hero_died(hero: HeroResource, node: Node2D, pos: Vector2)
signal enemy_hero_died(node: Node2D)
signal tower_died(node: Node2D)
signal match_elapsed_time(time: int)
