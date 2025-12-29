extends Control
@onready var play = $VBoxContainer/Play
@onready var options = $Options
@onready var back = $Options/Back

func _process(delta: float) -> void:
	if State.played == true and play.text != "Play Again":
		play.text = "Play Again"
		
func _ready() -> void:
	options.visible = false

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_options_pressed() -> void:
	options.visible = true

func _on_back_pressed() -> void:
	options.visible = false

func _on_exit_pressed() -> void:
	get_tree().quit()
