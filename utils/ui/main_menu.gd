extends Control

func _ready() -> void:
	DataStore.save_game_data()

func _on_start_button_pressed() -> void:
	ScreenChanger.change_to("main")
