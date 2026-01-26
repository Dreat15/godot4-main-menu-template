extends Control

func _ready() -> void:
	update_language()
	setup_language()
	volume_slider.value = 100

func _on_back_button_pressed() -> void:
	queue_free()

func _on_h_slider_value_changed(value: float) -> void:
	var rounded = roundi(value)
	volume_label.text = tr("SETTINGS_AUDIO_VOLUME") + " " + str(rounded) + "%"
	 
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
	update_language()

func update_language():
	#audio
	audio_tab.name = tr("SETTINGS_AUDIO")	
	volume_label.text = tr("SETTINGS_AUDIO_VOLUME") #add value when implemented
	#video
	video_tab.name = tr("SETTINGS_VIDEO")
	#controls
	controls_tab.name = tr("SETTINGS_CONTROLS")
	#language
	language_tab.name = tr("SETTINGS_LANGUAGE")
	language_language_label.text = tr("SETTINGS_LANGUAGE")
	back_button.text = tr("BACK")


#audio
@onready var audio_tab:MarginContainer = $Background/VBoxContainer/TabContainer/Audio
@onready var volume_label:Label = $Background/VBoxContainer/TabContainer/Audio/VBoxContainer/Label
@onready var volume_slider:HSlider = $Background/VBoxContainer/TabContainer/Audio/VBoxContainer/HSlider
@onready var volume_sample:AudioStreamPlayer2D = $Background/VBoxContainer/TabContainer/Audio/VBoxContainer/AudioStreamPlayer2D

#video
@onready var video_tab:VBoxContainer = $Background/VBoxContainer/TabContainer/Video

#controls
@onready var controls_tab:VBoxContainer = $Background/VBoxContainer/TabContainer/Controls

#language
@onready var language_tab:MarginContainer = $Background/VBoxContainer/TabContainer/Language
@onready var language_option_button:OptionButton = $Background/VBoxContainer/TabContainer/Language/VBoxContainer/OptionButton
@onready var language_language_label:Label = $Background/VBoxContainer/TabContainer/Language/VBoxContainer/Label

@onready var back_button:Button = $Background/VBoxContainer/BackButton
