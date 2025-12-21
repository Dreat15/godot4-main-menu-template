extends Control

@onready var volume_label:Label = $Background/VBoxContainer/TabContainer/Audio/VBoxContainer/Label
@onready var volume_slider:HSlider = $Background/VBoxContainer/TabContainer/Audio/VBoxContainer/HSlider
@onready var volume_sample:AudioStreamPlayer2D = $Background/VBoxContainer/TabContainer/Audio/VBoxContainer/AudioStreamPlayer2D

func _ready() -> void:
	volume_slider.value = 100

func _on_back_button_pressed() -> void:
	queue_free()


func _on_h_slider_value_changed(value: float) -> void:
	var rounded = roundi(value)
	volume_label.text = str("Volume ", rounded, "%") 
	AudioServer.set_bus_volume_db(0, value/5)
	volume_sample.play()
