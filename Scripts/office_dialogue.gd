extends Area2D
var entered = false
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
const Balloon = preload("uid://cdypc2qpghp1x")
var started = false

# Need to do brother killing functionality and brother hiding functionlaity


func _process(delta: float) -> void:
	if entered and !started:
		action()
	
func action() -> void:
	if State.finished_bro_dialogue == false:
		started = true
		var balloon: Node = Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_resource, dialogue_start)
	
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		entered = true

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		entered = false
