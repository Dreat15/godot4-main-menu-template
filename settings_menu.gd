extends Control

@onready var volume_label:Label = $Background/VBoxContainer/TabContainer/Audio/VBoxContainer/Label
@onready var volume_slider:HSlider = $Background/VBoxContainer/TabContainer/Audio/VBoxContainer/HSlider
@onready var volume_sample:AudioStreamPlayer2D = $Background/VBoxContainer/TabContainer/Audio/VBoxContainer/AudioStreamPlayer2D

@onready var language_option_button:OptionButton = $Background/VBoxContainer/TabContainer/Language/VBoxContainer/OptionButton
@onready var language_language_label:Label = $Background/VBoxContainer/TabContainer/Language/VBoxContainer/Label

func _ready() -> void:
	set_strings()
	setup_language()
	volume_slider.value = 100

func _on_back_button_pressed() -> void:
	queue_free()

func _on_h_slider_value_changed(value: float) -> void:
	var rounded = roundi(value)
	volume_label.text = str("Volume ", rounded, "%") 
	AudioServer.set_bus_volume_db(0, value/5)
	#volume_sample.play()
	
func setup_language() -> void:
	language_language_label.text = tr("SETTINGS_LANGUAGE")
	var langs = TranslationServer.get_loaded_locales()
	for lang in langs:
		language_option_button.add_item(lang)

func _on_option_button_item_selected(index: int) -> void:
	var locale:String = language_option_button.get_item_text(index)
	TranslationServer.set_locale(locale)
	set_strings()

func set_strings():
	language_language_label.text = tr("SETTINGS_LANGUAGE")
