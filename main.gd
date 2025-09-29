extends Node2D

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		ScreenChanger.change_to("main_menu")
		
