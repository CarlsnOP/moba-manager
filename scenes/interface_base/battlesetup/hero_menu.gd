extends PanelContainer


func _ready():
	SignalManager.new_interface.connect(new_interface)
	hide()

func new_interface(_state) -> void:
	if visible:
		hide()
