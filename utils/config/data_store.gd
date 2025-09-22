extends Node
## Node Name: DataStore
## This is an autoloader for saving game config and state to the users machine

const SAVE_PATH := "user://save_data.json"

var data:Dictionary[String, DataModel] = {
	"Audio" : AudioData.new(),
	"Input" : InputData.new(),
	"Game" : GameData.new(),
}

func _ready() -> void:
	load_game_data()

func save_game_data() -> void:
	var data_dict = _data_to_dict()
	var json_string := JSON.stringify(data_dict)
	var file_access := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	
	if not file_access:
		printerr(FileAccess.get_open_error())
		return
	
	file_access.store_line(json_string)
	file_access.close()

func load_game_data() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	
	var file_access := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json_string := file_access.get_line()
	file_access.close()

	var json := JSON.new()
	var error := json.parse(json_string)
	if error:
		printerr(json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return
	
	for key in data:
		if not json.data.has(key):
			printerr("Save file was missing data for ", key)
		data[key].from_dict(json.data[key])

func _data_to_dict() -> Dictionary:
	var dict := { }
	for key in data:
		dict[key] = data[key].to_dict()
	return dict
