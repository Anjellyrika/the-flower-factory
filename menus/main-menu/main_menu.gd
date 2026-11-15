extends Control

@onready var music_player: AudioStreamPlayer2D = $MusicPlayer

func _ready() -> void:
	music_player.play()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	SfxPlayer.play(preload("res://assets/sounds/woof1.mp3"))
	get_tree().change_scene_to_file("res://menus/intro.tscn")
	DialogueManager.show_dialogue_balloon(load("res://dialogue/prologue.dialogue"), "start")
	await DialogueManager.dialogue_ended
	
