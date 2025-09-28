class_name InputData
extends DataModel

var up_events := ["W", "UP"]
var down_events := ["S", "DOWN"]
var left_events := ["A", "LEFT"]
var right_events := ["D", "RIGHT"]

func _init() -> void:
	set_meta("title", "Input")
