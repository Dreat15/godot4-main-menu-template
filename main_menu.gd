extends Control

signal start_game()

func _ready() -> void:
	var preferred_language = OS.get_locale_language()
	TranslationServer.set_locale(preferred_language)
	update_language()
	
func _on_start_game_button_pressed() -> void:
	start_game.emit()
	hide()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_options_button_pressed() -> void:
	get_tree().current_scene.add_child(settings_scene.instantiate())

func update_language() -> void:
	main_menu_label.text = tr("MENU_MAIN_MENU")
	start_game_button.text = tr("MENU_START")
	options_button.text = tr("MENU_OPTIONS")
	quit_button.text = tr("MENU_QUIT")


@onready var main_menu_label:Label = $MarginContainer/VBoxContainer/Label
@onready var start_game_button:Button = $MarginContainer/VBoxContainer/ButtonVBox/StartGameButton
@onready var options_button:Button = $MarginContainer/VBoxContainer/ButtonVBox/OptionsButton
@onready var quit_button:Button = $MarginContainer/VBoxContainer/ButtonVBox/QuitButton

@onready var settings_scene:PackedScene = load("res://settings_menu.tscn")
