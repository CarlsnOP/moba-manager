class_name InventoryDialog
extends Control


enum SORT_BY_STATE { RARITY, NAME, QUANTITY }


@export var loot_slot_scene:PackedScene

@onready var loot = %Loot
@onready var equipped_equipment = %EquippedEquipment
@onready var equipment = %Equipment

var _state: SORT_BY_STATE = SORT_BY_STATE.NAME

func _ready():
	SignalManager.on_battle_end.connect(on_battle_end)

func open():
	loot.display(InventoryManager._all_loot)
	equipment.display(InventoryManager._all_equipment)
	equipped_equipment.display(TeamManager.get_equipped_equipment())
	
	set_state(SORT_BY_STATE.RARITY, loot)
	set_state(SORT_BY_STATE.RARITY, equipment)

func on_battle_end(_win: bool) -> void:
	if visible:
		loot.update_quanities()

#Statemachine is a bit overkill, but is good for later if implementing more sorting options
func set_state(new_state: SORT_BY_STATE, inv) -> void:
	_state = new_state
	
	match _state:
		SORT_BY_STATE.RARITY:
			sort_rarity(inv)

func sort_rarity(inv) -> void:
	var sorted_nodes = inv.get_children()
	
	sorted_nodes.sort_custom(sort_by_rarity_and_name)
	
	for node in inv.get_children():
		inv.remove_child(node)
	
	for node in sorted_nodes:
		inv.add_child(node)

func sort_by_rarity_and_name(a: Node, b: Node):
	if a["_rarity"] == b["_rarity"]:
		if a["_name"] < b["_name"]:
			return true
			
	elif a["_rarity"] < b["_rarity"]:
		return true
	
	return false
