extends Node2D

@onready var _objects: TileMapLayer = $Objects
@onready var _rock_bonus: StaticBody2D = $"Objects/Rock-Bonus"
@onready var _hose_bonus: Channel = $"BonusNodes/Hose-Bonus"
@onready var _cat: Cat = $BonusNodes/Cat
@onready var _water_system: WaterSystem = $WaterSystem
@onready var _player: CharacterBody2D = $Player

var _bonus_started: bool = false

func _ready() -> void:
	if 'CAT' in AnimalFriends.unlocked:
		print('cat in unlocked list')
		reveal_bonus()


func reveal_bonus() -> void:
	if _bonus_started:
		return
	_bonus_started = true
	_player.set_physics_process(false)
	_player.set_process_unhandled_input(false)

	_cat.reparent(self)
	_cat.show()
	await _cat.play_bonus(_objects)

	# Swap Rock and bonus Hose
	_objects.remove_child(_rock_bonus)
	_rock_bonus.queue_free()
	_hose_bonus.reparent(_objects)
	_hose_bonus.show()
	_water_system.register_channel(_hose_bonus)
	_water_system.update_water_flow()
	_player.set_physics_process(true)
	_player.set_process_unhandled_input(true)


func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_1/level_1.tscn")
