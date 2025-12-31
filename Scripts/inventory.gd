extends CanvasLayer
@onready var items = $Background/Items

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	items.text = State.item
