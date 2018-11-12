extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
enum TileBound {Closed, Open};

#               X-         Z+      X+       Z-
enum Direction {SOUTH, 	  EAST,    NORTH,  WEST};


func get_tile_properties():
	return [
		#           X-         Z+      X+       Z-
		{"bounds": [Closed,   Open, Closed,       Open]},
		{"bounds": [Closed,   Open, Closed,     Closed]},
		{"bounds": [Closed,   Open,   Open,     Closed]},
		{"bounds": [Closed,   Open,   Open,       Open]}, ]

func make_random_world():
	print("Building world")



	var grid_map = get_tree().get_root().find_node("GridMap", true, false)
	# for x in range(-10, 10):
	# 	for z in range(-10, 10):
	# 		grid_map.set_cell_item(x, 0, z, randi() % 4)
	var main_path_length = 100;
	var origin = Vector3(-5, 0, -5)
	var last_tile_coord = origin
	var last_direction = EAST

	grid_map.clear()
	# place origin
	grid_map.set_cell_item(origin[0], 0, origin[2], 1);

	for i in range(0, main_path_length):
		var continue_straight  = randi() % 2
		var next_direction = last_direction

		if continue_straight and i != 0:
			next_direction = randi() % 4
		else:
			next_direction = last_direction


		var translation_vector_for_direction_list = [
			Vector3(-1, 0, 0), # south
			Vector3( 0, 0, 1), # east
			Vector3( 1, 0, 0), # north
			Vector3( 0, 0, -1), # west
		]
		var translation_for_direction  = translation_vector_for_direction_list[next_direction]
		var next_tile_position = last_tile_coord + translation_for_direction

		if grid_map.get_cell_item(next_tile_position[0], 0, next_tile_position[2]) >= 0:
			# cannot break in previous wall, retry 
			continue
		
		var tile_to_use = -1
		var orientation_for_direction_list = [16, 0, 22, 10]
		if last_direction != next_direction:
			# it's a turn, so update current tile
			var bend_orientation_index = 0
			if last_direction == 1 and next_direction == 0:
				bend_orientation_index = 3
			if last_direction == 0 and next_direction == 1:
				bend_orientation_index = 1
			if last_direction == 1 and next_direction == 2:
				bend_orientation_index = 0
			if last_direction == 2 and next_direction == 1:
				bend_orientation_index = 2
			if last_direction == 2 and next_direction == 3:
				bend_orientation_index = 3
			if last_direction == 3 and next_direction == 0:
				bend_orientation_index = 2
			if last_direction == 3 and next_direction == 2:
				bend_orientation_index = 1
			var bend_orientation = orientation_for_direction_list[bend_orientation_index]

			grid_map.set_cell_item(last_tile_coord[0], 0, last_tile_coord[2], 2,
			 bend_orientation);
			# grid_map.set_cell_item(last_tile_coord[0], 0, last_tile_coord[2], -1);
			tile_to_use = 0
		else:
			# it's straight, so use tile 0
			tile_to_use = 0

		# var orientation_for_direction_list = [3, 0, 1, 2]
		var orientation_for_direction = orientation_for_direction_list[next_direction]
		grid_map.set_cell_item(next_tile_position[0], 0, next_tile_position[2], tile_to_use, orientation_for_direction);
		last_tile_coord = next_tile_position
		last_direction = next_direction
		print(" %d %d direction %s " % [next_tile_position[0], next_tile_position[2], next_direction]  )
	



	print("Done Building world")
	set_process_input(true)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	# print("GridMap size " + String(grid_map.cell_size))
	make_random_world()

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass

func _input(event):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if event.is_action_pressed("generate_new_world"):
		make_random_world()
