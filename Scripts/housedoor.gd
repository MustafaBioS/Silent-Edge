extends Area2D
var entered = false
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
const Balloon = preload("uid://cgduucytreo0u")
@onready var popup = $"../DoorPopup"
@onready var second_visit = $"../SecondVisit"
const BOSS_BALLOON = preload("uid://cnke2kq4a6tgr")
const BOSS = preload("uid://baldp5h3daimt")

func _ready() -> void:
	popup.visible = false

func boss_action() -> void:
	if State.broKilled:
		var balloon: Node = BOSS_BALLOON.instantiate()
		get_tree().current_scene.add_child(balloon)
		BOSS_BALLOON.start(BOSS, "start")

func action() -> void:
	if State.finished_sec_dialogue == false:
		var balloon: Node = Balloon.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(dialogue_resource, dialogue_start)


func _process(delta: float) -> void:
	if State.broKilled == false || State.broSaved == false:
		second_visit.visible = false
	
	if entered and Input.is_action_just_pressed("interact") and State.in_dialogue == false:
		get_tree().change_scene_to_file("res://Scenes/boss_house.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		popup.visible = true
		entered = true
	
	if State.finished_sec_visit_dial == false && State.broKilled == true:
		boss_action()
	
	if State.finished_sec_dialogue == false && State.broKilled == false || State.broSaved == false:
		action()


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		popup.visible = false
		entered = false
