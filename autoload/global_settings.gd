extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_settings()

func load_settings() -> void:
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")

	if err != OK:
		return

	#audio
	var volume = config.get_value("audio", "volume", 100)
	AudioServer.set_bus_volume_db(0, volume/5)
	#video
	var vsync = config.get_value("video", "vsync", 2)

	if vsync == 0: # Disabled (default)
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	elif vsync == 1: # Adaptive
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ADAPTIVE)
	elif vsync == 2: # Enabled
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)

	var fullscreen = config.get_value("video", "fullscreen", true)
	
	if(fullscreen):
		get_tree().root.set_mode(Window.MODE_FULLSCREEN)
	else:
		get_tree().root.set_mode(Window.MODE_WINDOWED)
	#controls
	#language
	var locale = config.get_value("language", "locale", OS.get_locale_language())
	TranslationServer.set_locale(locale)
