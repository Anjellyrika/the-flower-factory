## Wheelbarrows carry water forward after a short "filling time" delay and can be rotated.
## Input on one side, output on the opposite side
## Interact to adjust the rotation
extends Channel

const DIRECTION_FRAMES: SpriteFrames = preload("res://objects/channels/wheelbarrow_frames.tres")

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx_player: AudioStreamPlayer2D = $SFX

var tutorial_done = false

func _ready() -> void:
	sprite.sprite_frames = DIRECTION_FRAMES
	_update_sprite()


func interact() -> void:
	if tutorial_done == true:
		rotate_clockwise()
		sfx_player.play()
		return
	DialogueManager.show_dialogue_balloon(load("res://dialogue/level1.dialogue"), "interact_wheelbarrow")
	await DialogueManager.dialogue_ended
	rotate_clockwise()
	sfx_player.play()
	tutorial_done = true


func rotate_clockwise() -> void:
	rotation += PI / 2.0
	_update_sprite()
	changed.emit()


func _update_sprite() -> void:
	sprite.rotation = -rotation
	match get_output_direction():
		Vector2i.LEFT:
			sprite.frame = 0
		Vector2i.RIGHT:
			sprite.frame = 1
		Vector2i.UP:
			sprite.frame = 2
		Vector2i.DOWN:
			sprite.frame = 3
