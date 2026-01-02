extends HSlider

@export var audio_bus_name: String
var audio_bus_id

func _ready() -> void:
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)
	print("Bus:", audio_bus_name, "ID:", audio_bus_id)

func _on_value_changed(value: float) -> void:
	print("Slider moved:", audio_bus_name, value)
	var db := linear_to_db(max(value, 0.001))
	AudioServer.set_bus_volume_db(audio_bus_id, db)
