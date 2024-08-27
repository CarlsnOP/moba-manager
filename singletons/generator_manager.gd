extends Node


var _generated_rubberduckies_per_tick := 1

var tick_duration := 2.0

func generate_rubberduckies() -> void:
	CurrencyManager.create_rubberduckies(_generated_rubberduckies_per_tick)
