extends Sprite

export (NodePath) var structure_list_path

var target_3d

func _on_Structure_list_item_selected(index):
	var slot = get_node(structure_list_path).get_item_metadata(index)
	self.visible = true
	target_3d = slot.global_transform.origin
	
func _process(delta):
	if target_3d == null:
		return

	var camera = get_viewport().get_camera()
	global_position = camera.unproject_position(target_3d)
