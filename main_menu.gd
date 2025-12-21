extends Control

signal start_game()

@onready var settings_scene:PackedScene = load("res://settings_menu.tscn")

func _on_start_game_button_pressed() -> void:
	start_game.emit()
	hide()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_options_button_pressed() -> void:
	get_tree().current_scene.add_child(settings_scene.instantiate())
