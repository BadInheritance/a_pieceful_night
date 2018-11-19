extends Node

class PieceType:
	var name
	var scene
	
	func _init(name, piece_id):
		self.name = name
		self.scene = load("res://robot/robot-" + piece_id + ".dae")


var pieces = [
	PieceType.new("Tracks", "base-Tracks"),
	PieceType.new("Block", "piece-Block"),
	PieceType.new("Machinegun", "piece-Machinegun"),
	PieceType.new("Scannerhead", "piece-ScannerHead"),
	PieceType.new("Tower", "piece-Tower"),
]
