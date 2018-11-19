extends ItemList

export(NodePath) var libraryPath

var library

func _ready():
	library = get_node(libraryPath)
	
	var i = 0
	for piece in library.pieces:
		self.add_item(piece.name)
		self.set_item_metadata(i, piece)
		i += 1

