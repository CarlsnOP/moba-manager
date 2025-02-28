class_name InventoryDialog
extends Control


enum SORT_BY_STATE { RARITY, NAME, QUANTITY }


@export var loot_slot_scene:PackedScene

@onready var loot = %Loot
@onready var equipped_equipment = %EquippedEquipment
@onready var equipment = %Equipment
@onready var equipped_equipment_label = %EquippedEquipmentLabel
@onready var equipment_label = %EquipmentLabel
@onready var such_empty_label = %SuchEmptyLabel


var _state: SORT_BY_STATE = SORT_BY_STATE.NAME

func _ready():
	SignalManager.on_battle_end.connect(on_battle_end)

func open():
	loot.display(InventoryManager._all_loot)
	equipment.display(InventoryManager._all_equipment)
	equipped_equipment.display(TeamManager.get_equipped_equipment())
	
	set_state(SORT_BY_STATE.RARITY, loot)
	set_state(SORT_BY_STATE.RARITY, equipment)
	
	equipped_equipment_label.visible = equipped_equipment.get_children().size() > 0
	equipment_label.visible = equipment.get_children().size() > 0
	if equipped_equipment_label.visible or equipment_label.visible:
		such_empty_label.hide()
	else:
		such_empty_label.show()

func on_battle_end(_win: bool) -> void:
	if visible:
		loot.display(InventoryManager._all_loot)
		FunctionWizard.sort_rarity(loot)
		FunctionWizard.sort_rarity(equipped_equipment)

#Statemachine is a bit overkill, but is good for later if implementing more sorting options
func set_state(new_state: SORT_BY_STATE, inv) -> void:
	_state = new_state
	
	match _state:
		SORT_BY_STATE.RARITY:
			FunctionWizard.sort_rarity(inv)
			FunctionWizard.sort_rarity(equipped_equipment)


func _on_quit_button_pressed():
	SignalManager.new_interface.emit(InterfaceManager.INTERFACE_STATE.BATTLESIM)
