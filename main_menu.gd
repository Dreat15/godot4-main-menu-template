extends Control

signal start_game()

@onready var main_menu_label:Label = $MarginContainer/VBoxContainer/Label
@onready var settings_scene:PackedScene = load("res://settings_menu.tscn")

func _ready() -> void:
	#main_menu_label.text = tr("MENU_MAIN_MENU")
	#$MarginContainer/VBoxContainer/ButtonVBox/StartGameButton.text = tr("MENU_START")
	$MarginContainer/VBoxContainer/ButtonVBox/OptionsButton.text = tr("MENU_OPTIONS")
	$MarginContainer/VBoxContainer/ButtonVBox/QuitButton.text = tr("MENU_QUIT")
	
func _on_start_game_button_pressed() -> void:
	start_game.emit()
	hide()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_options_button_pressed() -> void:
	get_tree().current_scene.add_child(settings_scene.instantiate())
