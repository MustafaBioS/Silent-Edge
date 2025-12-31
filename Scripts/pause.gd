extends CanvasLayer
@onready var options = $Options
@onready var pause = $"."
@onready var backsfx = $BackSFX
@onready var clicksfx = $ClickSFX
@onready var audio = $Options/Audio
@onready var screen = $Options/Screen

func _ready() -> void:
	options.visible = false

func _on_resume_pressed() -> void:
	clicksfx.play()
	pause.visible = false
	State.paused = false

func _on_options_pressed() -> void:
	clicksfx.play()
	audio.visible = true
	screen.visible = false
	options.visible = true

func _on_back_pressed() -> void:
	backsfx.play()
	options.visible = false
	
func _on_menu_pressed() -> void:
	clicksfx.play()
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")

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
