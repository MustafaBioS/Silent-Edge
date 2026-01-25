extends Area2D
var entered = false
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
const Balloon = preload("uid://cgduucytreo0u")
@onready var popup = $"../DoorPopup"

func _ready() -> void:
	popup.visible = false

func action() -> void:
	if State.finished_sec_dialogue == false:
		var balloon: Node = Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_resource, dialogue_start)

func _process(delta: float) -> void:
	if entered and Input.is_action_just_pressed("interact"):
		get_tree().change_scene_to_file("res://Scenes/boss_house.tscn")

func _on_body_entered(body: Node2D) -> void:
	if not body.has_method("player"):
		return

	if body.has_method("player"):
		popup.visible = true
		entered = true
		
	if State.finished_sec_dialogue == false:
		print("entered")
		action()


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		popup.visible = false
		entered = false
