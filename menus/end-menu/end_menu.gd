extends Control

@onready var _cat: Sprite2D = $Container/Cat


func _ready() -> void:
	if "CAT" in AnimalFriends.unlocked:
		_cat.modulate = Color.WHITE
	DialogueManager.show_dialogue_balloon(load("res://dialogue/gameover.dialogue"), "start")


func _on_quit_pressed() -> void:
	get_tree().quit()
