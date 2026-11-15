extends Control

@onready var music_player: AudioStreamPlayer2D = $MusicPlayer

func _ready() -> void:
	music_player.play()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_1/level_1.tscn")
