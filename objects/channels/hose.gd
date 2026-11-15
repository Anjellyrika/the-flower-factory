## Hoses supply water from a distance and without following an input direction.
## Input on one side, output on the opposite side
## Interact to adjust the distance
extends Channel

const HOSE_UP: AudioStream = preload("res://assets/sounds/hose_up.wav")
const HOSE_DOWN: AudioStream = preload("res://assets/sounds/hose_down_trimmed.wav")
const DIRECTION_FRAMES: SpriteFrames = preload("res://objects/channels/hose_frames.tres")

@export_range(2, 4, 1) var distance := 2

@onready var pressure_label: Label = $PressureLabel
@onready var sfx: AudioStreamPlayer2D = $SFX
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var tutorial_done = false

func _ready() -> void:
	pressure_label.text = str(distance - 1)
	sprite.sprite_frames = DIRECTION_FRAMES
	_update_sprite()


func interact() -> void:
	if tutorial_done == true:
		adjust_pressure()
		return
	DialogueManager.show_dialogue_balloon(load("res://dialogue/level1.dialogue"), "interact_hose")
	await DialogueManager.dialogue_ended
	adjust_pressure()
	tutorial_done = true


func get_targets() -> Array[Vector2i]:
	return [cell + get_output_direction() * distance]


func can_supply(_target: Channel) -> bool:
	return true


func adjust_pressure() -> void:
	distance = 2 if distance == 4 else distance + 1
	pressure_label.text = str(distance - 1)
	_update_sprite()
	sfx.stream = HOSE_UP if distance == 4 else HOSE_DOWN
	sfx.play()
	changed.emit()


func _update_sprite() -> void:
	sprite.rotation = -rotation
	match get_output_direction():
		Vector2i.LEFT:
			sprite.animation = &"left"
		Vector2i.RIGHT:
			sprite.animation = &"right"
		Vector2i.UP:
			sprite.animation = &"up"
		Vector2i.DOWN:
			sprite.animation = &"down"
	sprite.frame = 4 - distance
