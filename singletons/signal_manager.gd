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
signal on_battle_end(win: bool)
signal friendly_hero_died(hero: HeroResource, node: Node2D, pos: Vector2)
signal event(actor: PhysicsBody2D, killer: PhysicsBody2D)
