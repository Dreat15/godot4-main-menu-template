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
		language_option_button.add_item(lang)
	
	var index := langs.find(TranslationServer.get_locale())
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
	fullscreen_label.text = tr("SETTINGS_VIDEO_FULLSCREEN")
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
	config.set_value("video", "vsync", v_sync_option_button.get_selected_id())
	config.set_value("video", "fullscreen", fullscreen_option_button.get_selected_id() == 1)
	#controls
	#language
	config.set_value("language", "locale", TranslationServer.get_locale())
	config.save("user://settings.cfg")

func load_settings() -> void:
	#audio
	var volume = AudioServer.get_bus_volume_db(0) * 5
	volume_slider.value = volume
	#video
	var vsync = DisplayServer.window_get_vsync_mode()
	v_sync_option_button.select(vsync)
	var window_mode =get_tree().root.get_mode()
	fullscreen_option_button.select(window_mode == Window.MODE_FULLSCREEN)
	#controls
	#language
	var locale = TranslationServer.get_locale()
	language_option_button.select(TranslationServer.get_loaded_locales().find((locale)))

func _on_v_sync_item_selected(index: int) -> void:
	if index == 0: # Disabled (default)
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	elif index == 1: # Adaptive
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ADAPTIVE)
	elif index == 2: # Enabled
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)

func _on_fullscreen_item_selected(index: int) -> void:
	if(index == 1):
		get_tree().root.set_mode(Window.MODE_FULLSCREEN)
	else:
		get_tree().root.set_mode(Window.MODE_WINDOWED)

signal settings_closed() 

#audio
@onready var audio_tab:MarginContainer = $Background/VBoxContainer/TabContainer/Audio
@onready var volume_label:Label = $Background/VBoxContainer/TabContainer/Audio/VBoxContainer/Label
@onready var volume_slider:HSlider = $Background/VBoxContainer/TabContainer/Audio/VBoxContainer/HSlider
@onready var volume_sample:AudioStreamPlayer2D = $Background/VBoxContainer/TabContainer/Audio/VBoxContainer/AudioStreamPlayer2D

#video
@onready var video_tab:VBoxContainer = $Background/VBoxContainer/TabContainer/Video
@onready var v_sync_option_button:OptionButton = $Background/VBoxContainer/TabContainer/Video/VSync
@onready var fullscreen_label:Label = $Background/VBoxContainer/TabContainer/Video/FullscreenLabel
@onready var fullscreen_option_button:OptionButton = $Background/VBoxContainer/TabContainer/Video/Fullscreen
#controls
@onready var controls_tab:VBoxContainer = $Background/VBoxContainer/TabContainer/Controls

#language
@onready var language_tab:MarginContainer = $Background/VBoxContainer/TabContainer/Language
@onready var language_option_button:OptionButton = $Background/VBoxContainer/TabContainer/Language/VBoxContainer/OptionButton
@onready var language_language_label:Label = $Background/VBoxContainer/TabContainer/Language/VBoxContainer/Label

@onready var back_button:Button = $Background/VBoxContainer/BackButton