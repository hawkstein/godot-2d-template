class_name UIBuilder
extends RefCounted

func build_section_from_model(data_model:DataModel) -> PanelContainer:
	var title = data_model.get_meta("title", "404")
	var child_nodes = _build_inputs(data_model)
	var section = _build_section(title, child_nodes)
	return section


func _build_inputs(data_model:DataModel) -> Array[Control]:
	var props = data_model.get_property_list()
	var nodes:Array[Control] = []
	for p in props:
		if p.usage == PROPERTY_USAGE_SCRIPT_VARIABLE:
			var p_label = data_model.get_meta(p.name, "404")
			if p.type == Variant.Type.TYPE_FLOAT:
				nodes.append(_build_slider(p_label, data_model.get(p.name), data_model.update.bind(p.name)))
	return nodes


func _build_section(section_title:String, child_nodes:Array[Control]) -> PanelContainer:
	var section = PanelContainer.new()
	var margin = MarginContainer.new()
	var v_box = VBoxContainer.new()
	var label = Label.new()
	label.text = section_title
	const MARGIN = 10
	margin.add_theme_constant_override("margin_top", MARGIN)
	margin.add_theme_constant_override("margin_right", MARGIN)
	margin.add_theme_constant_override("margin_bottom", MARGIN)
	margin.add_theme_constant_override("margin_left", MARGIN)
	margin.add_child(v_box)
	section.add_child(margin)
	v_box.add_child(label)
	for child in child_nodes:
		v_box.add_child(child)
	return section


func _build_slider(label_text:String, slider_value:float, callable:Callable) -> HBoxContainer:
	var container = HBoxContainer.new()
	var label = Label.new()
	label.text = label_text
	container.add_child(label)
	var slider = HSlider.new()
	slider.max_value = 1.0
	slider.step = 0.05
	slider.value = slider_value
	slider.value_changed.connect(callable)
	slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	container.add_child(slider)
	return container
