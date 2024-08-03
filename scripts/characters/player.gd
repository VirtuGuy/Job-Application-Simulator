extends CharacterBody2D

# Constants
const speed: float = 120

# Keys
const kLeft: String = "move_left"
const kRight: String = "move_right"
const kUp: String = "move_up"
const kDown: String = "move_down"

func _physics_process(_delta):
	# Movement X
	var inputDirX = Input.get_axis(kLeft, kRight)
	if inputDirX:
		velocity.x = inputDirX * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	# Movement Y
	var inputDirY = Input.get_axis(kUp, kDown)
	if inputDirY:
		velocity.y = inputDirY * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
	
	move_and_slide()
