extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
const Balloon = preload("uid://cgduucytreo0u")

func action() -> void:
	if State.finished_dialogue == false:
		var balloon: Node = Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_resource, dialogue_start)

func _on_body_entered(body: Node2D) -> void:
	if State.finished_dialogue == false:
		action()
