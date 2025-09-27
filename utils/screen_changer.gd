extends Node

@export var screens:Dictionary[String, PackedScene] = {}

func _ready() -> void:
	var root = get_tree().root
	print(root)

func change_to(current:Node, key:String) -> void:
	if not screens.has(key):
		push_warning("Key does not exist: ", key)
		return
	if not current.is_inside_tree():
		push_error("Current node is not in the scene tree")
		return
	call_deferred("_deferred_goto_scene", current, key)

func _deferred_change_to(current:Node, key:String) -> void:
	await Fade.fade_out().finished
	current.get_tree().change_scene_to_packed(screens[key])
	Fade.fade_in()
