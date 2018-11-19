extends Spatial


signal structure_changed


var this_script = load("res://src/RobotSlot.gd")


func _ready():
	pass


func _activate_slots():
	var queue = self.get_children()
	while len(queue) > 0:
		var node = queue.pop_front()
		
		if node.name.begins_with("slot"):
			node.set_script(this_script)
		
		for child in node.get_children():
			queue.append(child)


func set_child(child):
	for child in self.get_children():
		self.remove_child(child)
		child.queue_free()

	if child != null:
		self.add_child(child)
		_activate_slots()
	
	emit_signal("structure_changed")
