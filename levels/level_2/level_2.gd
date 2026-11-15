extends Node2D


func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_1/level_1.tscn")
