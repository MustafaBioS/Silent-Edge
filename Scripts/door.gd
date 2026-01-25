extends Area2D
var entered = false
@onready var popup: Label = $"../HousePopup"

func _ready() -> void:
	popup.visible = false

func _process(delta: float) -> void:
	if entered and Input.is_action_just_pressed("interact"):
		print(State.house)
		State.house = true
		print(State.house)
		get_tree().change_scene_to_file("res://Scenes/house.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		popup.visible = true
		entered = true

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		popup.visible = false
		entered = false
