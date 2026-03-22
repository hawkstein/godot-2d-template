extends Control

@onready var v_box_container: VBoxContainer = $MarginContainer/VBoxContainer/ScoresContainer/VBoxContainer

func _ready() -> void:
	pass

func _on_back_button_pressed() -> void:
	ScreenChanger.change_to("main_menu")
