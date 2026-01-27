extends Area2D
var entered = false
@onready var popup: Label = $"../Popup"

func _ready() -> void:
	popup.visible = false

func _process(delta: float) -> void:
	if entered:
		if Input.is_action_just_pressed("interact"):
			get_tree().change_scene_to_file("res://Scenes/boss_house.tscn")
			State.objective = "Get In The Warehouse"

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		popup.visible = true
		entered = true

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		popup.visible = false
		entered = false
