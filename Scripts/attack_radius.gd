extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
var entered = false
const Balloon = preload("uid://cgduucytreo0u")
@onready var target = $"../Target"

func _process(delta: float) -> void:
	if entered and Input.is_action_just_pressed("interact"):
		target.queue_free()
		action()
		
	if State.gameover == true:
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func action() -> void:
	if State.finished_final == false:
		var balloon: Node = Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_resource, dialogue_start)

func _on_body_entered(body: Node2D) -> void:
	entered = true

func _on_body_exited(body: Node2D) -> void:
	entered = false
