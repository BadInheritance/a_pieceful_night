extends Spatial

export (NodePath) var structure_list_path

func _on_Structure_list_item_selected(index):
	var slot = get_node(structure_list_path).get_item_metadata(index)
	self.global_transform.origin = slot.global_transform.origin