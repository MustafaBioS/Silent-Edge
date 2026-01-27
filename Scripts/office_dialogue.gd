extends Area2D
var entered = false
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
const Balloon = preload("uid://cdypc2qpghp1x")
const phone_balloon = preload("uid://cgduucytreo0u")

var started = false
@onready var popup = $"../BroPopup"
@onready var door_popup = $"../DoorPopup"
@onready var killSFX = $"../KillSFX"
@onready var target = $"../Target"
@onready var asprite = $"../Target/AnimatedSprite2D"
const KILLED = preload("uid://cptt1bnp2qp3h")
var door_entered = false
@onready var anim = $"../Animation/AnimationPlayer"
@onready var consequences = $"../HUD/Consequences"
var kill = false
var save = false
var playing = false


func consequence():
	if playing:
		return
		
	playing = true
	
	consequences.text = "This Action Will Have Consequences."
	await get_tree().create_timer(0.3).timeout
	
	consequences.text = "This Action Will Have Consequences.."
	await get_tree().create_timer(0.3).timeout
	
	consequences.text = "This Action Will Have Consequences..."
	await get_tree().create_timer(0.3).timeout
	
	playing = false

func _ready() -> void:
	popup.visible = false
	door_popup.visible = false

func cutscene():
	var destination = Vector2(-57.0, -14.5)
	var move_vector = destination - target.global_position
	walk_dir(move_vector)
	
	var tween = create_tween()
	tween.tween_property(target, "global_position", destination, 2.0)
	tween.tween_callback(func():
		asprite.stop()
		target.visible = false
	)

func walk_dir(move_vector: Vector2):
	if move_vector == Vector2.ZERO:
		asprite.animation = "default"

	if abs(move_vector.x) > abs(move_vector.y):
		if move_vector.x > 0:
			asprite.animation = "walk_right"
		else:
			asprite.animation = "walk_left"
	else:
		if move_vector.y > 0:
			asprite.animation = "walk_down"
		else:
			asprite.animation = "walk_top"
	
	asprite.play()

func _process(delta: float) -> void:

	print(State.show_consequences)
	
	if State.show_consequences == false:
		consequences.visible = false
	
	if State.show_consequences and not playing:
		consequences.visible = true
		consequence()
		await get_tree().create_timer(2.5).timeout
		State.show_consequences = false
	
	if entered and !started:
		action()
		
	if State.killBro:
		popup.text = "E - Kill Brother"
		
	if State.saveBro:
		popup.text = "E - Hide Brother"
	
	if !State.broKilled || !State.broSaved:
		door_popup.text = "Locked"
		
	if kill and Input.is_action_just_pressed("interact"):
		killSFX.play()
		if target:
			target.queue_free()
		State.broKilled = true
		popup.visible = false
		
		
		if State.finished_kill_dial == false:
			started = true
			var balloon: Node = phone_balloon.instantiate()
			get_tree().current_scene.add_child(balloon)
			balloon.start(KILLED, "start")
			
			State.objective = "Pick Up The Money"
			await get_tree().create_timer(2.0).timeout
			anim.play("fade_out")
			await anim.animation_finished
			get_tree().change_scene_to_file("res://Scenes/house.tscn")
			
	if save and Input.is_action_just_pressed("interact"):
		cutscene()
		State.broSaved = true
		popup.visible = false
		
	if door_entered and Input.is_action_just_pressed("interact") and State.broKilled || State.broSaved:
		get_tree().change_scene_to_file("res://Scenes/incompany.tscn")
	
func action() -> void:
	if State.finished_bro_dialogue == false:
		started = true
		var balloon: Node = Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_resource, dialogue_start)
	
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		entered = true

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		entered = false

func _on_popup_area_body_entered(body: Node2D) -> void:
	if body.has_method("player") and State.broSaved == false  and State.broKilled == false:
		popup.visible = true
		
		if State.killBro:
			kill = true

		if State.saveBro:
			save = true

func _on_popup_area_body_exited(body: Node2D) -> void:
	if body.has_method("player") and State.broSaved == false  and State.broKilled == false:
		popup.visible = false
		
		if State.killBro:
			kill = false

		if State.saveBro:
			save = false


func _on_door_popup_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		door_entered = true
		door_popup.visible = true


func _on_door_popup_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		door_entered = false
		door_popup.visible = false
