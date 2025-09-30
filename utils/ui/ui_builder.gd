class_name UIBuilder
extends RefCounted

func build_section_from_model(data_model:DataModel) -> Control:
	var title = data_model.get_meta("title", "404")
	var child_nodes = _build_inputs(data_model)
	var section = _build_section(title, child_nodes)
	return section


func _build_inputs(data_model:DataModel) -> Array[Control]:
	var props = data_model.get_property_list()
	var nodes:Array[Control] = []
	for p in props:
		if p.usage == PROPERTY_USAGE_SCRIPT_VARIABLE:
			if p.type == Variant.Type.TYPE_FLOAT:
				nodes.append(_build_slider(p.name, data_model))
			elif p.type == Variant.Type.TYPE_BOOL:
				nodes.append(_build_toggle(p.name, data_model))
			elif p.type == Variant.Type.TYPE_ARRAY:
				nodes.append(_build_mapper(p.name, data_model))
	return nodes


func _build_section(section_title:String, child_nodes:Array[Control]) -> Control:
	var wrapper = Control.new()
	wrapper.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	var section = PanelContainer.new()
	section.anchor_left = 0
	section.anchor_right = 1
	section.anchor_top = 0
	section.anchor_bottom = 1
	wrapper.add_child(section)
	var margin = MarginContainer.new()
	var v_box = VBoxContainer.new()
	var label = Label.new()
	label.text = section_title
	margin.add_theme_constant_override("margin_top", 10)
	margin.add_theme_constant_override("margin_right", 10)
	margin.add_theme_constant_override("margin_bottom", 10)
	margin.add_theme_constant_override("margin_left", 10)
	margin.add_child(v_box)
	section.add_child(margin)
	v_box.add_child(label)
	for child in child_nodes:
		v_box.add_child(child)
	return wrapper


func _build_slider(prop_name:String, data_model:DataModel) -> Control:
	var prop_meta = data_model.get_meta(prop_name)
	var container = HBoxContainer.new()
	var label = Label.new()
	label.text = prop_meta.label
	container.add_child(label)
	var slider = HSlider.new()
	slider.min_value = prop_meta.min_value
	slider.max_value = prop_meta.max_value
	slider.step = prop_meta.step
	slider.value = data_model.get(prop_name)
	slider.value_changed.connect( data_model.update.bind(prop_name) )
	slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	container.add_child(slider)
	return container

func _build_toggle(prop_name:String, data_model:DataModel) -> Control:
	var prop_meta = data_model.get_meta(prop_name)
	var container = HBoxContainer.new()
	var label = Label.new()
	label.text = prop_meta.label
	container.add_child(label)
	var toggle = CheckBox.new()
	toggle.text = "Show/hide"
	toggle.button_pressed = data_model.get(prop_name)
	toggle.toggled.connect( data_model.update.bind(prop_name) )
	toggle.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	container.add_child(toggle)
	return container


func _build_mapper(prop_name:String, data_model:DataModel) -> Control:
	var prop_meta = data_model.get_meta(prop_name)
	var container = HBoxContainer.new()
	var label = Label.new()
	label.text = prop_meta.label
	container.add_child(label)
	var events = data_model.get(prop_name) as Array[String]
	for event_code in events:
		var remap_button = RemapButton.new(event_code)
		remap_button.keycode_updated.connect(data_model.update.bind(prop_name))
		container.add_child(remap_button)
	return container
