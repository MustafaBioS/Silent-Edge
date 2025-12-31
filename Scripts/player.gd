extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var pause = $"../../Pause"
@onready var inv = $"../../Inventory"
@onready var click_sfx = $"../../ClickSFX"
@onready var back_sfx = $"../../BackSFX"

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

func player():
	pass
	
func _ready() -> void:
	pause.visible = false
	inv.visible = false

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("inv") and State.in_dialogue == false:
		if inv.visible:
			backsfx.play()
			inv.visible = false
		elif !inv.visible:
			clicksfx.play()
			inv.visible = true
	
	if State.finished_final == true:
		await get_tree().create_timer(1.5).timeout
		State.played = true
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	
	if Input.is_action_just_pressed("pause"):
		if !State.in_dialogue:
			if pause.visible == true:
				backsfx.play()
				pause.visible = false
				State.paused = false
			elif pause.visible == false:
				clicksfx.play()
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
