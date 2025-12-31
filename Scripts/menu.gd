extends Control
@onready var play = $VBoxContainer/Play
@onready var options = $Options
@onready var back = $Options/Back
@onready var backsfx = $BackSFX
@onready var clicksfx = $ClickSFX
@onready var audio = $Options/Audio
@onready var screen = $Options/Screen
@onready var anim = $AnimationPlayer

func _process(delta: float) -> void:
	if State.played == true and play.text != "Play Again":
		play.text = "Play Again"
		
func _ready() -> void:
	options.visible = false
	anim.play("fade_in")
	await anim.animation_finished

func _on_play_pressed() -> void:
	clicksfx.play()
	anim.play("fade_out")
	await anim.animation_finished
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_options_pressed() -> void:
	clicksfx.play()
	audio.visible = true
	screen.visible = false
	options.visible = true

func _on_back_pressed() -> void:
	backsfx.play()
	options.visible = false

func _on_exit_pressed() -> void:
	clicksfx.play()
	get_tree().quit()

func _on_audio_btn_pressed() -> void:
	clicksfx.play()
	audio.visible = true
	screen.visible = false

func _on_screen_btn_pressed() -> void:
	clicksfx.play()
	screen.visible = true
	audio.visible = false
