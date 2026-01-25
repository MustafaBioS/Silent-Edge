extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
var enteredCrate = false
const Balloon = preload("uid://bg4mirjxc0wv7")
@onready var popup = $"../CratePopup"

func _ready() -> void:
	popup.visible = false

func _process(delta: float) -> void:
	if enteredCrate and Input.is_action_just_pressed("interact"):
		action()

func action() -> void:
	if State.finished_aq == false and enteredCrate == true:
		var balloon: Node = Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_resource, dialogue_start)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		popup.visible = true
		enteredCrate = true

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		popup.visible = false
		enteredCrate = false
