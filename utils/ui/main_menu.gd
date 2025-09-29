extends Control
@onready var start_container: VBoxContainer = $MarginContainer/StartVBoxContainer
@onready var options_container: VBoxContainer = $MarginContainer/OptionsVBoxContainer

func _ready() -> void:
	var builder := UIBuilder.new()
	var audio_section = builder.build_section_from_model(DataStore.get_model("Audio"))
	options_container.add_child(audio_section)
	var gameplay_section = builder.build_section_from_model(DataStore.get_model("Gameplay"))
	options_container.add_child(gameplay_section)
	
	start_container.show()
	options_container.hide()


func _on_start_button_pressed() -> void:
	ScreenChanger.change_to("main")


func _on_options_button_pressed() -> void:
	start_container.hide()
	options_container.show()


func _on_back_button_pressed() -> void:
	start_container.show()
	options_container.hide()


func _on_credits_button_pressed() -> void:
	ScreenChanger.change_to("credits")
