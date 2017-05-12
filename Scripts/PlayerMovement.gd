extends KinematicBody2D

const GRAVITY = 400
const JUMP_HEIGHT = -200
const SPEED = 200
var velocity = Vector2()

func _ready():
	set_process(true)
	pass

func _process(delta):
	
	velocity.y += delta * GRAVITY
	
	#If not moving left OR right, stay still
	if(!Input.is_action_pressed("ui_right") && !Input.is_action_pressed("ui_left")):
		velocity.x = 0
	
	#Handle left
	if Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
	#Handle right
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		
	var motion = velocity * delta
	move(motion)
	
		
	if (is_colliding()):
		#The normal
		var normal = get_collision_normal()
		motion = normal.slide(motion)
		velocity = normal.slide(velocity)
		move(motion)
		
		if(Input.is_action_pressed("ui_up")):
			velocity.y = JUMP_HEIGHT
	
	