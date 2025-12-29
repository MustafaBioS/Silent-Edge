extends CanvasLayer
@onready var options = $Options
@onready var pause = $"."


func _ready() -> void:
	options.visible = false

func _on_resume_pressed() -> void:
	pause.visible = false
	State.paused = false

func _on_options_pressed() -> void:
	options.visible = true

func _on_back_pressed() -> void:
	options.visible = false
	
func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
