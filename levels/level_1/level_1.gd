extends Node2D


func _ready() -> void:
	SfxPlayer.play(preload("res://assets/sounds/dreaming of a better tomorrow.mp3"), -10)


func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_2/level_2.tscn")
