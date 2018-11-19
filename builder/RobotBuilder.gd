extends WorldEnvironment

export (NodePath) var library_list_path
export (NodePath) var structure_list_path

var library_list
var structure_list

signal structure_changed

func _ready():
	library_list = get_node(library_list_path)
	structure_list = get_node(structure_list_path)

func _get_selected(item_list):
	var sel_items = item_list.get_selected_items()
	if len(sel_items) == 1:
		return sel_items[0]
	else:
		return null

func _get_selected_metadata(item_list):
	var index = _get_selected(item_list)
	if index == null:
		return null
	return item_list.get_item_metadata(index)

func _attach_piece():
	var library_piece = _get_selected_metadata(library_list)
	var slot = _get_selected_metadata(structure_list)
	
	if library_piece == null or slot == null:
		print("attach: Nothing selected")
		return
	
	slot.set_child(library_piece.scene.instance())
	emit_signal("structure_changed")

