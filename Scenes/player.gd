extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	
	if Input.is_action_pressed("w"):
		input_vector.y -= 1
	if Input.is_action_pressed("s"):
		input_vector.y += 1
	if Input.is_action_pressed("a"):
		input_vector.x -= 1
	if Input.is_action_pressed("d"):
		input_vector.x += 1
		
	input_vector = input_vector.normalized()
	
	velocity = input_vector * SPEED
	move_and_slide()
