extends Area2D
var entered = false
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
@onready var popup = $"../DoorPopup"
@onready var second_visit = $"../SecondVisit"
const BOSS = preload("uid://baldp5h3daimt")
const BOSS_BALLOON = preload("uid://cnke2kq4a6tgr")
@onready var bag_popup = $"../SecondVisit/BagPopup"
var bag_picked = false
@onready var bag = $"../SecondVisit/Bag"
@onready var cash_sfx = $"../CashSFX"
@onready var animCon = $"../AnimationOut"
@onready var anim = $"../AnimationOut/AnimationPlayer"
@onready var col1 = $"../SecondVisit/StaticBody2D/CollisionShape2D"
@onready var col2 = $"../SecondVisit/Boss/CollisionShape2D"
@onready var animCon2 = $"../AnimationOut2"
@onready var anim2 = $"../AnimationOut2/AnimationPlayer"


func _ready() -> void:
	popup.visible = false
	bag_popup.visible = false
	animCon.visible = false
	animCon2.visible = false

func boss_action() -> void:
	if State.broKilled and !State.finished_boss_dial:
		var balloon: Node = BOSS_BALLOON.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(BOSS, "start")
		

func _process(delta: float) -> void:
	
	if State.broKilled and !bag_picked and Input.is_action_just_pressed("interact"):
		bag_popup.visible = false
		animCon.visible = true
		cash_sfx.play()
		bag.queue_free()
		bag_picked = true
		anim.play("fade_out_text")
		await anim.animation_finished
		State.played = true
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	
	if State.broSaved and !bag_picked and Input.is_action_just_pressed("interact"):
		bag_popup.visible = false
		animCon2.visible = true
		cash_sfx.play()
		bag.queue_free()
		bag_picked = true
		anim2.play("fade_out_text")
		await anim2.animation_finished
		State.played = true
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
		
	
	if State.broKilled == false && State.broSaved == false:
		second_visit.visible = false
		col1.disabled = true
		col2.disabled = true
	else:
		second_visit.visible = true
		col1.disabled = false
		col2.disabled = false
	
	if State.broKilled == true || State.broSaved == true:
		popup.text = "Locked"
	
	if entered and Input.is_action_just_pressed("interact") and State.in_dialogue == false:
		if State.broKilled == true|| State.broSaved == true:
			return
		
		if State.finished_boss_dial == false:
			State.objective = "Get In The Car"
			get_tree().change_scene_to_file("res://Scenes/boss_house.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		popup.visible = true
		entered = true
	
	if State.finished_sec_visit_dial == false && State.broKilled == true:
		boss_action()

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		popup.visible = false
		entered = false

func _on_bag_area_body_entered(body: Node2D) -> void:
	if body.has_method("player") and bag_picked == false:
		bag_popup.visible = true

func _on_bag_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		bag_popup.visible = false
