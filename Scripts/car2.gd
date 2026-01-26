extends Area2D
var entered = false
@onready var popup: Label = $"../CarPopup"

var popupText = "";

func _ready() -> void:
	popup.visible = false

func _process(delta: float) -> void:
	
	popup.text = popupText
	
	if State.opened_crate == true:
		popupText = "E - Interact"
	else:
		popupText = "Locked"
	
	if entered:
		if Input.is_action_just_pressed("interact"):
			if State.opened_crate == true:
				get_tree().change_scene_to_file("res://Scenes/company.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		popup.visible = true
		entered = true

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		popup.visible = false
		entered = false
