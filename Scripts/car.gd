extends Area2D
var entered = false

func _process(delta: float) -> void:
	if entered:
		if Input.is_action_just_pressed("interact"):
			print("interacted")

func _on_body_entered(body: Node2D) -> void:
	entered = true

func _on_body_exited(body: Node2D) -> void:
	entered = false
