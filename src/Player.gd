extends KinematicBody

const SPEED = 10
const GRAVITY = -9.8

var direction
var velocity

func _ready():
	direction = Vector3(0,0,0)
	velocity = Vector3(0,0,0)

func _process(delta):
#	input control
	direction = Vector3()
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_up"):
		direction.z -= 1
	if Input.is_action_pressed("ui_down"):
		direction.z += 1
	
	direction = direction.normalized()
	
	velocity.y += GRAVITY
	velocity.x = direction.x*SPEED
	velocity.z = direction.z*SPEED
	velocity = move_and_slide(velocity, Vector3(0,1,0))
