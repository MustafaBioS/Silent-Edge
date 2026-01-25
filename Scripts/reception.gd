extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
const Balloon = preload("uid://c46jk1su3sow2")

func _process(delta: float) -> void:
	pass
	# Player Lose Functionality When Librarian Calls The Cops

func action() -> void:
	if State.finished_rec_dialogue == false:
		var balloon: Node = Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_resource, dialogue_start)

func _on_body_entered(body: Node2D) -> void:
	if State.finished_rec_dialogue == false:
		action()
