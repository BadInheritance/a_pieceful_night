extends KinematicBody

const SPEED = 100

var speed_ 
var direction_
var velocity_

func _process(delta):
	velocity_ = direction_
	velocity_ = move_and_slide(velocity_, Vector3(0,1,0))
	
func set_starting_conditions(direction, position):
	direction_ = direction
	direction_ *= SPEED
	translation = position