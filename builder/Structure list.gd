extends ItemList

export(NodePath) var robot_base_path

func _ready():
	read_structure()

func get_slots():
	var slots = []
	
	var queue = [get_node(robot_base_path)]
	while len(queue) > 0:
		var node = queue.pop_back()
		if node.name.begins_with("slot"):
			slots.append(node)

		for child in node.get_children():
			queue.append(child)
	
	return slots

func read_structure():
	self.clear()
	
	var slots = get_slots()
	
	var i = 0
	for slot in slots:
		self.add_item(slot.name)
		self.set_item_metadata(i, slot)
		i += 1

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
