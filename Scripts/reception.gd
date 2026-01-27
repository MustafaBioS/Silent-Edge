extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
const Balloon = preload("uid://cecfjcr47dwns")
@onready var popup = $"../ReceptionPopup"
@onready var door_popup = $"../DoorPopup"

@onready var anim = $"../LoseAnim/AnimationPlayer"
@onready var lose_anim = $"../LoseAnim"

var entered = false
var entered_door = false
var restarting = false

func _ready() -> void:
	popup.visible = false
	lose_anim.visible = false

func _process(delta: float) -> void:
	if State.lost and not restarting:
		restarting = true
		_start_lose_sequence()
	
	if entered_door && Input.is_action_just_pressed("interact") && State.broKilled || State.broSaved:
		get_tree().change_scene_to_file("res://Scenes/company.tscn")

	if entered and Input.is_action_just_pressed("interact"):
		action()
	
	if State.broKilled || State.broSaved:
		door_popup.text = "E - Interact"
	else:
		door_popup.text = "Locked"

func _start_lose_sequence() -> void:
	lose_anim.visible = true
	anim.play("fade_out")
	await anim.animation_finished
	get_tree().reload_current_scene()
	State.lost = false
	State.in_dialogue = false
	restarting = false

func action() -> void:
	if not State.finished_rec_dialogue:
		var balloon := Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_resource, dialogue_start)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		popup.visible = true
		entered = true

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		popup.visible = false
		entered = false

func _on_door_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		door_popup.visible = true
		entered_door = true

func _on_door_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		door_popup.visible = false
		entered_door = false
