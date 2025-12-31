extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
var entered = false
const Balloon = preload("uid://cgduucytreo0u")
@onready var target = $"../Target"

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if entered and Input.is_action_just_pressed("interact") and target:
		target.queue_free()
		action()
		_cutscene()
		
	if State.gameover == true:
		await get_tree().create_timer(1.0).timeout
		State.played = true
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func _cutscene():
	if State.finished_final == true:
		State.in_dialogue = true
		await get_tree().create_timer(0.5).timeout
		State.in_dialogue = false

func action() -> void:
	if State.finished_final == false:
		var balloon: Node = Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_resource, dialogue_start)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		entered = true
		
	if not body.has_method("player"):
		return
		
func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		entered = false
		
	if not body.has_method("player"):
		return
