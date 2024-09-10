extends Node

#load game
signal on_log_entry(node)

#Menus
signal on_hero_selected(hero: String)
signal on_portrait_selected(hero: String)
signal new_interface(state: int)

#Currency
signal rubberduckies_updated
signal rubberduckies_created(quantity: int)
signal rubberduckies_spent(quantity: int)

#Battle
signal on_battle_end
signal on_jungle_clear(lane_state: LaneState, new_lane_state: LaneState)
signal on_jungle_respawn_enemy()
signal on_jungle_respawn_team()
