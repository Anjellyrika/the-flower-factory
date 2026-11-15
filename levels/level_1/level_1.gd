extends Node2D


func _ready() -> void:
	SfxPlayer.play(preload("res://assets/sounds/dreaming of a better tomorrow.mp3"), -10)
	DialogueManager.show_dialogue_balloon(load("res://dialogue/level1.dialogue"), "start")


func _on_continue_pressed() -> void:	
	DialogueManager.show_dialogue_balloon(load("res://dialogue/level1.dialogue"), "level1_complete")
	await DialogueManager.dialogue_ended
	get_tree().change_scene_to_file("res://levels/level_2/level_2.tscn")
