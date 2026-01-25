extends Area2D
var entered = false
@onready var popup = $"../ElevatorPopup"
var popupText = ""

func _ready() -> void:
	popup.visible = false

func _process(delta: float) -> void:

	if State.elevator_route == true || State.recKilled == true:
		popupText = "E - Interact"
	else:
		popupText = "Locked"

	popup.text = popupText

	if entered and Input.is_action_just_pressed("interact"):
		if State.elevator_route == true || State.recKilled == true:
			get_tree().change_scene_to_file("res://Scenes/office.tscn")



func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		popup.visible = true
		entered = true

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		popup.visible = false
		entered = false
