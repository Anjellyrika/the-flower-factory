extends Node

const all_animals: Dictionary[String, PackedScene] = {
	'CAT': preload("res://entity/cat.tscn")
}

var unlocked: Array[String] = []

func unlock_animal(animal: String):
	unlocked.append(animal)
	
