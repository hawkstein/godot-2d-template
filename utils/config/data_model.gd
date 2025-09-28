class_name DataModel
extends RefCounted

var property_updated:Callable

func to_dict() -> Dictionary:
	var props = get_property_list()
	var dict: Dictionary = { }
	
	for p in props:
		if p.usage == PROPERTY_USAGE_SCRIPT_VARIABLE and not p.name == "property_updated":
			dict[p.name] = get(p.name)
	
	return dict

func from_dict(dict: Dictionary):
	var props = get_property_list()
	
	for p in props:
		if dict.has(p.name):
			set(p.name, dict[p.name])


func update(value:Variant, property_name:StringName) -> void:
	print("Update {0} to {1}".format([property_name, value]))
	set(property_name, value)
	if property_updated:
		property_updated.call(property_name)
