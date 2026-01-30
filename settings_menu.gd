class_name  SettingsMenu extends Control

func _ready() -> void:
	load_settings()
	update_language()
	setup_language()

func _on_back_button_pressed() -> void:
	save_settings()
	settings_closed.emit()
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
		print("Adding language option: ", lang)
		language_option_button.add_item(lang)
	
	var index := langs.find(TranslationServer.get_locale())
	print("Current locale index: ", index)
	if index != -1:
		language_option_button.select(index)

func _on_option_button_item_selected(index: int) -> void:
	var locale:String = language_option_button.get_item_text(index)
	TranslationServer.set_locale(locale)
	update_language()

func update_language():
	#audio
	audio_tab.name = tr("SETTINGS_AUDIO")	
	volume_label.text = tr("SETTINGS_AUDIO_VOLUME") + " " + str(roundi(volume_slider.value)) + "%"
	#video
	video_tab.name = tr("SETTINGS_VIDEO")
	#controls
	controls_tab.name = tr("SETTINGS_CONTROLS")
	#language
	language_tab.name = tr("SETTINGS_LANGUAGE")
	language_language_label.text = tr("SETTINGS_LANGUAGE")
	back_button.text = tr("BACK")

func save_settings() -> void:
	var config = ConfigFile.new()

	#audio
	config.set_value("audio", "volume", volume_slider.value)
	#video
	#controls
	#language
	config.set_value("language", "locale", TranslationServer.get_locale())
	config.save("user://settings.cfg")

func load_settings() -> void:
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")

	if err != OK:
		return

	print("Loaded settings from file.")
	#audio
	var volume = config.get_value("audio", "volume", 100)
	volume_slider.value = volume
	AudioServer.set_bus_volume_db(0, volume/5)
	#video
	#controls
	#language
	var locale = config.get_value("language", "locale", OS.get_locale_language())
	TranslationServer.set_locale(locale)

signal settings_closed() 

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
