class_name DataModel
extends Object

var meta:Dictionary[String, MetaData] = { }

func to_dict() -> Dictionary:
	var props = self.get_property_list()
	var dict: Dictionary = { }
	
	for p in props:
		if not p.name == "meta" and p.usage == PROPERTY_USAGE_SCRIPT_VARIABLE:
			dict[p.name] = get(p.name)
		
	return dict

func from_dict(dict: Dictionary):
	var props = get_property_list()
	
	for p in props:
		if p.usage == PROPERTY_USAGE_SCRIPT_VARIABLE and dict.has(p.name):
			var value = dict[p.name]
			set(p.name, value)

class MetaData:
	var input := "Slider"
