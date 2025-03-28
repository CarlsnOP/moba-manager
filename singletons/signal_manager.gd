extends Node

#load game
signal on_log_entry(node)
signal first_time_launch()

#Menus
signal on_hero_selected(hero: String)
signal new_interface(state: int)
signal show_change_warning()

#Currency
signal rubberduckies_updated
signal rubberduckies_created(quantity: int)
signal rubberduckies_spent(quantity: int)
signal on_loot_ducky()
signal update_stats()

#Battle
signal on_battle_end(win: bool)
signal friendly_hero_died(hero: HeroResource, node: Node2D, pos: Vector2)
signal event(actor: PhysicsBody2D, killer: PhysicsBody2D)
signal on_minions_spawn()
signal restart_match()

#Battle Manager
signal manual_wait_time_changed(value: float)

#Achievements
signal achievements_updated()
signal on_equipment_crafted(equipment: EquipmentResource)
signal on_unclaimed_rewards()
signal on_all_claimed_rewards()

#Tutorial
signal rubberduck_clicked()
signal hero_selected()
