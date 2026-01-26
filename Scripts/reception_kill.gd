extends Area2D
var entered = false
@onready var librarian = $"../Librarian"
@onready var killSFX = $"../KillSFX"
@onready var popup = $"../ReceptionPopup"

func _process(delta: float) -> void:
	
	if State.killRec == true:
		popup.text = "E - Kill Receptionist"

	if entered and Input.is_action_just_pressed("interact") and State.killRec == true:
		killSFX.play()
		librarian.visible = false
		State.recKilled = true
		popup.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		entered = true

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("false"):
		entered = false
