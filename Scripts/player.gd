extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var pause = $"../../Pause"

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

func player():
	pass
	
func _ready() -> void:
	pause.visible = false

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("pause"):
		if !State.in_dialogue:
			if pause.visible == true:
				pause.visible = false
				State.paused = false
			elif pause.visible == false:
				pause.visible = true
				State.paused = true
	
	var input_vector = Vector2.ZERO
	
	if Input.is_action_pressed("w") and State.in_dialogue == false and State.paused == false: 
		input_vector.y -= 1
		sprite.frame = 1
	if Input.is_action_pressed("s") and State.in_dialogue == false and State.paused == false:
		input_vector.y += 1
		sprite.frame = 0
	if Input.is_action_pressed("a") and State.in_dialogue == false and State.paused == false:
		input_vector.x -= 1
		sprite.frame = 2
	if Input.is_action_pressed("d") and State.in_dialogue == false and State.paused == false:
		input_vector.x += 1
		sprite.frame = 3
		
	input_vector = input_vector.normalized()
	
	velocity = input_vector * SPEED
	move_and_slide()
