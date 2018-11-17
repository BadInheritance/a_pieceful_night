extends KinematicBody

# DATA
const SPEED = 10
const GRAVITY = -9.8

var facing_
var velocity_
var bullets_

var bullet_scene_ = preload("res://scenes/bullet.tscn")

# FUNCTIONS
func _ready():
	facing_ = Vector3(1,0,-1)
	velocity_ = Vector3(0,0,0)
	bullets_ = []

func _process(delta):
#	MOVEMENT
	var direction = Vector3()
	var moved = false
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
		direction.z -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		direction.z += 1
	if Input.is_action_pressed("ui_down"):
		direction.x -= 1
		direction.z += 1
	if Input.is_action_pressed("ui_up"):
		direction.x += 1
		direction.z -= 1
		
	if direction != Vector3():
		moved = true
		
	direction = direction.normalized()
	if moved:
		facing_ = direction
	
	velocity_.y += GRAVITY
	velocity_.x = direction.x*SPEED
	velocity_.z = direction.z*SPEED
	velocity_ = move_and_slide(velocity_, Vector3(0,1,0))

#	SHOOTING	
	if Input.is_action_just_pressed("shoot"):
		var bullet = bullet_scene_.instance()
		bullet.set_starting_conditions(facing_,
			   translation+Vector3(1.5,0,0))
		bullets_.push_back(bullet)
		get_parent().add_child(bullet)